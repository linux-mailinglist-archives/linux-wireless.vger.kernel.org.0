Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145E124F1F6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 06:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHXEf2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 00:35:28 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13312 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgHXEf1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 00:35:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598243727; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Xvm4AtKm0GVrHPoJKOSY7BI7uGNEis4klWDs9zXdANg=;
 b=AD8zpZ6z9FG+GeODE9tBSa/e/7/Al+mClOiM6voQNTJqhf2/4h0RL6VqdiJRKMt44WcIF4sk
 JI3aatX3nRUdmCs/qn3sk0Cje3jo8LOY4rR9wI1//Q+901Zq9Cc/1cid+NnScDkcEUgHIQQn
 9mW0oPFbE+qWY1JIpfQlN6WhuVo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f43438ea0b59f2b43839c84 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Aug 2020 04:35:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2801C43387; Mon, 24 Aug 2020 04:35:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81742C433CA;
        Mon, 24 Aug 2020 04:35:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Aug 2020 12:35:25 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
In-Reply-To: <f58ad98479e54a5bbe8b6561563d8cc7@codeaurora.org>
References: <20200214035555.24762-1-wgong@codeaurora.org>
 <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
 <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org>
 <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
 <dcc45384935dca14ac6ab31ec1123414@codeaurora.org>
 <CABPxzYLu_81h+aWWeNKRyH=CJ=+waB3zmT41BTZ9Mo733PqErQ@mail.gmail.com>
 <acb2bd58-2f95-e09c-9575-b45c0e2aeb70@candelatech.com>
 <CABPxzY+tPos8ByT76hU1ngoxwYcBHaRpFMCKGQJcc_ssoqGNSw@mail.gmail.com>
 <47c1b1e0-afc4-b9b4-5fc0-4636d8b3b981@candelatech.com>
 <CABPxzYLD-M5wpWF6r=K=8YTosSfjctmaaBPCyBP72q-mY0PTcw@mail.gmail.com>
 <CABPxzYLOZf9Fu5O3Rt_mVcXeFLuuFAsqyvd7jiCVvJ0x2BN-+g@mail.gmail.com>
 <dd8cb5db-f164-c235-1f39-cd78ea97f8be@candelatech.com>
 <CABPxzY+uyy_Yc0mHb7sJGxxUE5__Z8SpywodAv2YCM8D89waHw@mail.gmail.com>
 <c69abe52-ccd1-ac73-8691-d87f5ed8be76@candelatech.com>
 <f58ad98479e54a5bbe8b6561563d8cc7@codeaurora.org>
Message-ID: <6b59e4db2c5ae9deb4959acd52108fb6@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-21 10:45, Wen Gong wrote:
...
> I have 2 cmd, each one can reproduce the hang.
> echo soft >
> /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;sleep
> 0.05;ifconfig wlan0 down
> echo soft >
> /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;rmmod
> ath10k_sdio
> and with the my patch, it fix the hang. Change of my patch is similar 
> with your
> patch(https://patchwork.kernel.org/patch/10249365/), so it should also
> fix the hang with your patch.
I have sent v2: https://patchwork.kernel.org/patch/11732165/
