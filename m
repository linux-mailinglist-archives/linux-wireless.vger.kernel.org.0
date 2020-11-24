Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01A22C2AAF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 16:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbgKXPCU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 10:02:20 -0500
Received: from z5.mailgun.us ([104.130.96.5]:11775 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388995AbgKXPCT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 10:02:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606230139; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=GnvwklEVjjriXF1yYIK8EoCGRuCuwkOeNeHMOFGCEts=;
 b=UtbDKXm2FbQfpjsoN9/esTnVvXu/jvNpK2wrLZOLXjqWtOhBdDBmM8/0XL/JcJfThJHLNH+X
 evxMymt6avP0za3feTpMZUCa/dMW5jIlMY0aK7kpZ4XO1jg+JhHRh/HEfJ3Dn6Yb2gItufKf
 qM/u8M+MMEstf9jZodmUZ1d8kxE=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fbd2067e9b7088622b10670 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 15:01:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74085C433ED; Tue, 24 Nov 2020 15:01:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1206C433C6;
        Tue, 24 Nov 2020 15:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1206C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] orinoco: Move context allocation after processing
 the
 skb
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201113212252.2243570-2-bigeasy@linutronix.de>
References: <20201113212252.2243570-2-bigeasy@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-wireless@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dcbw@redhat.com>,
        Jes Sorensen <jes.sorensen@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201124150158.74085C433ED@smtp.codeaurora.org>
Date:   Tue, 24 Nov 2020 15:01:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> ezusb_xmit() allocates a context which is leaked if
> orinoco_process_xmit_skb() returns an error.
> 
> Move ezusb_alloc_ctx() after the invocation of
> orinoco_process_xmit_skb() because the context is not needed so early.
> ezusb_access_ltv() will cleanup the context in case of an error.
> 
> Fixes: bac6fafd4d6a0 ("orinoco: refactor xmit path")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

10 patches applied to wireless-drivers-next.git, thanks.

a31eb615646a orinoco: Move context allocation after processing the skb
915fd9db418f orinoco: Prepare stubs for in_interrupt() removal
29b2fe3f6f20 orinoco: Annotate ezusb_xmit()
46233f778604 orinoco: Annotate ezusb_init()
69476b25a4ba orinoco: Annotate firmware loading
154f2bae9bed orinoco: Annotate ezusb_read_pda()
39628fe48cb3 orinoco: Annotate ezusb_write_ltv()
47ab2a951eb9 orinoco: Remove ezusb_doicmd_wait()
a9a2678abacb orinoco: Annotate ezusb_docmd_wait()
a3d8a2599d47 orinoco: Annotate ezusb_read_ltv()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201113212252.2243570-2-bigeasy@linutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

