Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD1456EBB
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 13:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhKSMTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 07:19:38 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:26620 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhKSMTh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 07:19:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637324196; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=QXMbTi96aEUxlwxLuju/wCQpDRPLkSHBaX1Iy7nF+f0=; b=Vl+HbNoihuBDQ2FjsuYEGrEh/hR067IYOrd7BQSesTqIM2u64ZhumTFEmbj9oLdMkbf8pjBD
 Kc+NIEbyOWs8DD8Rm53g+Fa8M6w785Rxlfeq8goR8dEfC0/hu95feSubZUGuEeqVntOVGuB5
 ysyfJX/7qdUGLqhGFhvnwq3hMlg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 619795a3638a2f4d61fce531 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 12:16:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB6BAC43617; Fri, 19 Nov 2021 12:16:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 177C0C4338F;
        Fri, 19 Nov 2021 12:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 177C0C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7915: fix NULL pointer dereference in mt7915_get_phy_mode
References: <ddae419a740f1fb9e48afd432035e9f394f512ee.1637239456.git.lorenzo@kernel.org>
        <YZeFx0s8HUNtaODw@lore-desk>
Date:   Fri, 19 Nov 2021 14:16:28 +0200
In-Reply-To: <YZeFx0s8HUNtaODw@lore-desk> (Lorenzo Bianconi's message of "Fri,
        19 Nov 2021 12:08:55 +0100")
Message-ID: <87y25kcpcz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Fix the following NULL pointer dereference in mt7915_get_phy_mode
>> routine adding an ibss interface to the mt7915 driver.
>
> Hi Kalle and Felix,
>
> I guess we can apply this patch in wireless-drivers tree since the issue is
> already in Linus's tree. What do you think?

Yeah, I agree that this should go to wireless-drivers. Felix, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
