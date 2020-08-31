Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27D0257C44
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 17:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgHaP1l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 11:27:41 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:57105 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbgHaP1l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 11:27:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598887660; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=tHhW8DQ7EFoBVRy7ZkGCRTNfibqVktWQ04DE5bvgCqw=;
 b=ZQFFjCwIf+AbnkOLzjQ9qbcXc9iohXGNKlq+mAe3nmhbHDjdFjFHMjmMG92k6E1c+dRvnw5i
 pCo/2Vu/5R/wcVjkq6mz3+X7f7aBYtgUfQZS8egV7VeHI61B9UeuWwmdSRHbk2yjeRvwGHuU
 uzU6PpGz/oZAw/SHMYcM3sXRCxY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f4d16e432925f96e14e385d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 15:27:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94737C433C6; Mon, 31 Aug 2020 15:27:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CC3BC433CA;
        Mon, 31 Aug 2020 15:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CC3BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/15] rtlwifi: Start changing RT_TRACE into rtl_dbg
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200723204244.24457-2-Larry.Finger@lwfinger.net>
References: <20200723204244.24457-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200831152731.94737C433C6@smtp.codeaurora.org>
Date:   Mon, 31 Aug 2020 15:27:31 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> The macro name RT_TRACE makes it seem that it is used for tracing, when
> is actually used for debugging. Change the name to RT_DEBUG.
> 
> This step creates the new macro while keeping the old RT_TRACE to allow
> building. It will be removed at the end of the patch series.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

13 patches applied to wireless-drivers-next.git, thanks.

78a7245d8430 rtlwifi: Start changing RT_TRACE into rtl_dbg
f108a420e50a rtlwifi: Replace RT_TRACE with rtl_dbg
c8159c3ff8db rtlwifi: btcoexist: Replace RT_TRACE with rtl_dbg
57b0b743e402 rtlwifi: rtl8188ee: Rename RT_TRACE to rtl_dbg
5b4e998b8ae7 rtlwifi: rtl8192-common: Rename RT_TRACE to rtl_dbg
de0c8a968809 rtlwifi: rtl8192ce: Rename RT_TRACE to rtl_dbg
34d7f007171d rtlwifi: rtl8192cu: Rename RT_TRACE to rtl_dbg
6bf8bc19297b rtlwifi: rtl8192de: Rename RT_TRACE to rtl_dbg
e24a2a8795fb rtlwifi: rtl8192ee: Rename RT_TRACE to rtl_dbg
fca8218d33f3 rtlwifi: rtl8192se Rename RT_TRACE to rtl_dbg
8f11dad4145c rtlwifi: rtl8723ae Rename RT_TRACE to rtl_dbg
e6dd230a4d8e rtlwifi: rtl8723be Rename RT_TRACE to rtl_dbg
b58c18c88c20 rtlwifi: rtl8723-common: Rename RT_TRACE to rtl_dbg

-- 
https://patchwork.kernel.org/patch/11681599/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

