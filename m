Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C953B3416
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 18:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhFXQpV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 12:45:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38822 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231488AbhFXQpV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 12:45:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624552982; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=UrdwEsv/GeGu8n59uVeExy6KofQb0BPJZKoMnLtN7A4=;
 b=N5cFAA04QxJIDHMEiBHWNJ8cUJNay+DYWb53qJV4RRX9my5udim53CAONIBJqLyIrXMZ++AC
 2/kaU787gna5BKl+v5iQQnxnw/Nq6Ee33PM+AxZVEILXI7s2/w3/DPTbjGzhN97woog9yVMt
 UoXyBh9k9Fa9RAVheFNc7V9+IUc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60d4b5c37b2963a2826b0222 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 16:41:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2CFA8C433D3; Thu, 24 Jun 2021 16:41:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B17CC433F1;
        Thu, 24 Jun 2021 16:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B17CC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wireless: hostap: Fix a use after free in hostap_80211_rx
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210329110021.7497-1-lyl2019@mail.ustc.edu.cn>
References: <20210329110021.7497-1-lyl2019@mail.ustc.edu.cn>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     j@w1.fi, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210624164139.2CFA8C433D3@smtp.codeaurora.org>
Date:   Thu, 24 Jun 2021 16:41:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lv Yunlong <lyl2019@mail.ustc.edu.cn> wrote:

> Function hostap_80211_rx() calls prism2_rx_80211(..,skb,..). In
> prism2_rx_80211, i found that the skb could be freed by dev_kfree_skb_any(skb)
> and return 0. Also could be freed by netif_rx(skb) when netif_rx return
> NET_RX_DROP.
> 
> But after called the prism2_rx_80211(..,skb,..), the skb is used by skb->len.
> 
> As the new skb->len is returned by prism2_rx_80211(), my patch uses a variable
> len to repalce skb->len. According to another useage of prism2_rx_80211 in
> monitor_rx().
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>

Can someone help with reviewing the patch?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210329110021.7497-1-lyl2019@mail.ustc.edu.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

