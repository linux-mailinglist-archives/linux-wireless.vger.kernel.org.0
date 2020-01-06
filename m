Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C43131144
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 12:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAFLQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 06:16:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21663 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726155AbgAFLQr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 06:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578309406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tuqh4+wzkh3h72FXwCgmtaWHZGGKEAU3Y9D9hW4X+KE=;
        b=gfUham4XBLlzJEC8GK8IKztRsfRyGE7zxeLdNUcfsToWF38LAzg6wX4K8QVwpTdXuSI35z
        Wc9KVC0aCzXcN/KvmnK/AWM6TumEnP2lXMGHVwjUBI9kebgxiyZ8hBmZc3HXCbJGHsR9DF
        GHv4/DFtZULMGGTsCUSuRhUbmoz96w4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-cEQOn36-OSWFU1rctu61dQ-1; Mon, 06 Jan 2020 06:16:44 -0500
X-MC-Unique: cEQOn36-OSWFU1rctu61dQ-1
Received: by mail-wr1-f71.google.com with SMTP id w6so25756980wrm.16
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 03:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Tuqh4+wzkh3h72FXwCgmtaWHZGGKEAU3Y9D9hW4X+KE=;
        b=VqnpLHLB9A+fOcDbRN2hkMMJbGRXXbQzBEsvEFAwrYT8pkt9xqW1H3NJyFxrhg67Au
         dlfn3JF3J67SfqPeqN+mZfavEqybRLwvsIB/TbcQVgzsvsjK9+1p6y/DpPVx43YiJVHJ
         llQajZ+te245aTSi2qn/VbeDkllpWxt2/eyF5sa+dyl5FD7orA6oNxYEgFI9utDx3w4V
         ax5NTWzbYLH4LjdEWSu7fZhoH77Pdg7xWzOq2/2EVFadBxfIYCpOTCPVY9Pq4NEsgyU9
         GPtENG0gmzSQNHjjkUgY4yvbCy0m9b343m/tIeI6hJ3+fTV7yhIj0j27ZozPr5IenWjm
         EKwA==
X-Gm-Message-State: APjAAAWZv43pv2ZUU6Vc283Gts8f5MEC+3n6ekI3deRVgkL6Q2oKso1m
        v8VpfBfS3cP5hByXEiZUuZWiFSVqFCgHMB67bjwiyV1GfnQuI1zBbrKmel5noR2LG8wqwO15MHS
        irV4mD6o9+9nvbLeVYgdB4lcv6Ko=
X-Received: by 2002:a7b:c946:: with SMTP id i6mr33454750wml.28.1578309403610;
        Mon, 06 Jan 2020 03:16:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJIh+MXhB1jBDKoQT3mGXBEbeQpKrYi+0EpFLw+hg0cKxLvlDk/SXBMaVWL6xtOKWSekGBoA==
X-Received: by 2002:a7b:c946:: with SMTP id i6mr33454735wml.28.1578309403448;
        Mon, 06 Jan 2020 03:16:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l6sm2852059wmf.21.2020.01.06.03.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 03:16:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C16F4183515; Mon,  6 Jan 2020 12:16:40 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: Re: [PATCH] iw: info: print missing extended feature flag information
In-Reply-To: <20200101174836.5513-1-markus.theil@tu-ilmenau.de>
References: <20200101174836.5513-1-markus.theil@tu-ilmenau.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 06 Jan 2020 12:16:40 +0100
Message-ID: <8736csltrb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Markus Theil <markus.theil@tu-ilmenau.de> writes:

> Some extended feature flags were not considered before.
>
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  info.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/info.c b/info.c
> index 38362d8..0f24dae 100644
> --- a/info.c
> +++ b/info.c
> @@ -676,7 +676,17 @@ broken_combination:
>  		ext_feat_print(tb, DFS_OFFLOAD, "DFS offload");
>  		ext_feat_print(tb, CONTROL_PORT_OVER_NL80211,
>  			       "control port over nl80211");
> +		ext_feat_print(tb, ACK_SIGNAL_SUPPORT,
> +			       "ack signal level support");
>  		ext_feat_print(tb, TXQS, "FQ-CoDel-enabled intermediate TXQs");
> +		ext_feat_print(tb, SCAN_RANDOM_SN,
> +			       "use random sequence numbers in scans");
> +		ext_feat_print(tb, SCAN_MIN_PREQ_CONTENT,
> +			       "use probe request with only rate IEs in scans");
> +		ext_feat_print(tb, CAN_REPLACE_PTK0,
> +			       "can safely replace PTK 0 when rekeying");
> +		ext_feat_print(tb, ENABLE_FTM_RESPONDER,
> +			       "enable FTM (Fine Time Measurement) responder");
>  		ext_feat_print(tb, AIRTIME_FAIRNESS,
>  			       "airtime fairness scheduling");

I would prefer to keep TXQS and AIRTIME_FAIRNESS next to each other.

Also, while you're at it, could you please add the newly-added AQL
feature? Something like

  		ext_feat_print(tb, AIRTIME_FAIRNESS,
  			       "airtime fairness scheduling");
 +		ext_feat_print(tb, AQL,
 +			       "Airtime Queue Limits (AQL)");


-Toke

