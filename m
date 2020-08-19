Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF50324A4F8
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHSRdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 13:33:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36806 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgHSRdv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 13:33:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597858430; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=DWhrvKlsjo4TmgmXMHZrsUhfKqw28FGKf9FrletVwKA=; b=SX1L3GOzpLQ4Wox4LeoV5CTUADByJmFN+uV8kTms8RuQ4kkLuhpu4k990hc6UmhPMQt0imT4
 ZhXwXDHLBwOSyKfTzfaPGIVIknrS/SVNa3isc5qHPg2ygGefz2y5haDAFUgO5av5ypZfPh5a
 yYgAm48lP6znWEsPwaikJFLFZ3k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f3d627e1054562ec5148e10 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 17:33:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FD58C433CA; Wed, 19 Aug 2020 17:33:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52585C433C6;
        Wed, 19 Aug 2020 17:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52585C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Miles Hu <milehu@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH V6 2/2] ath11k: add more HE fields into radiotap header
References: <20200803145444.473810-1-john@phrozen.org>
        <20200803145444.473810-2-john@phrozen.org>
Date:   Wed, 19 Aug 2020 20:33:44 +0300
In-Reply-To: <20200803145444.473810-2-john@phrozen.org> (John Crispin's
        message of "Mon, 3 Aug 2020 16:54:44 +0200")
Message-ID: <87h7syilqf.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> From: Miles Hu <milehu@codeaurora.org>
>
> This patch adds code to parse HE fields inside ppdu TLVs. Then it adds the
> populates the additional info into the ratiotap header. Also fix missing
> QoS tag in native wifi mode. Finally rssi and tsf are also added.
>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: John Crispin <john@phrozen.org>

On what hardware and firmware was this tested?

I did quite a few cosmetic changes in the pending branch.

> +		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_BSS_COLOR, info0);
> +		ppdu_info->he_data3 = value;
> +		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_BEAM_CHANGE, info0);
> +		value = value << HE_BEAM_CHANGE_SHIFT;

[...]

> +#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_BEAM_CHANGE	BIT(1)
> +#define HE_BEAM_CHANGE_SHIFT 6

There's a lot of these shifts which I don't understand. Why not fix the
actual defines so that FIELD_GET() works correctly and no manual
shifting is needed? In this example from BIT(1) to BIT(7).

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
