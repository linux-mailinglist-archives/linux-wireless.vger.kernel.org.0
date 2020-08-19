Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7468724A4FF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 19:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSRe6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 13:34:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36806 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgHSRez (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 13:34:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597858495; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=zIkrDMdMP5Zcl5COLlaJMdeQajGRYu9X5/uuGnjVPiY=; b=Z4d7TKM5MygUumJzcy58Ctj7JE/viGvWjX4QBxi3YK/Vf8Ova1EoaLTJK+Dahvm0wmbg2/zY
 YQItVdKDj2Zm2lbNyCL473iPqScuaSp0cv+ryl/2HRsA0YUsPiinM1XjuYFAO0WAHm7ZvhoO
 1aM/22RlQ9KXxBi3G0Y6C5lXwII=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f3d62a8d84550423e9d132e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 17:34:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7DB7C433C6; Wed, 19 Aug 2020 17:34:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76980C433CA;
        Wed, 19 Aug 2020 17:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76980C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH V6 1/2] ath11k: switch to using ieee80211_tx_status_ext()
References: <20200803145444.473810-1-john@phrozen.org>
Date:   Wed, 19 Aug 2020 20:34:28 +0300
In-Reply-To: <20200803145444.473810-1-john@phrozen.org> (John Crispin's
        message of "Mon, 3 Aug 2020 16:54:43 +0200")
Message-ID: <87d03milp7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> This allows us to pass HE rates down into the stack.
>
> Signed-off-by: John Crispin <john@phrozen.org>

On what hardware and firmware was this tested?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
