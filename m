Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993702872C8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgJHKsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 06:48:15 -0400
Received: from z5.mailgun.us ([104.130.96.5]:45889 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgJHKsL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 06:48:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602154091; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=XF8bfasQgbyhvaE6NI3D51L1dNMgM/d3H7Cbk/K588w=;
 b=wgKhgIdh77arMoThDE4C6gYSkZSYDxy8B+Z6zASbCLxPDLTJhVIZ1FeWhy8rnWKYIcIoxrMy
 T1x5o97/rDv2vIHHS+Y4v8wM5PYyRe1vHDFH7+LTdAE94AkT0CvGNJf1D6mYv2gSAXZQxs5u
 n1F0A1Z/XX4RwsY1rSRbS5gJUho=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f7eee6857b88ccb562e5ee3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 10:48:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87109C433FF; Thu,  8 Oct 2020 10:48:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5603AC433F1;
        Thu,  8 Oct 2020 10:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5603AC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8192se: remove duplicated
 legacy_httxpowerdiff
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201006035928.5566-1-chiu@endlessm.com>
References: <20201006035928.5566-1-chiu@endlessm.com>
To:     Chris Chiu <chiu@endlessos.org>
Cc:     pkshih@realtek.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Chiu <chiu@endlessos.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201008104808.87109C433FF@smtp.codeaurora.org>
Date:   Thu,  8 Oct 2020 10:48:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chris Chiu <chiu@endlessos.org> wrote:

> From: Chris Chiu <chiu@endlessos.org>
> 
> The legacy_httxpowerdiff in rtl8192se is pretty much the same as
> the legacy_ht_txpowerdiff for other chips. Use the same name to
> keep the consistency.
> 
> Signed-off-by: Chris Chiu <chiu@endlessos.org>

Patch applied to wireless-drivers-next.git, thanks.

8b2426c50f20 rtlwifi: rtl8192se: remove duplicated legacy_httxpowerdiff

-- 
https://patchwork.kernel.org/patch/11818043/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

