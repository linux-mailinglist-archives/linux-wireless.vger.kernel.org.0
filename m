Return-Path: <linux-wireless+bounces-6226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD21A8A2829
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 09:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B0D281FCB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9236AEF;
	Fri, 12 Apr 2024 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih7/8Gea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430492C683
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907239; cv=none; b=EgI2OqyIEwmT0ccLgAY4142cja3g+nV/gQo4dvrUDem54sknDOLllPKyEy0Zz4GOLmfr7CanI0uMF4QR24odiaNesFiVeRs8ZUVlpjm2e8ix28MwFm2VoTVmQqO5xJJcuQ1ivrhREhKZ5hdaxB9gvs3vWk1ejBQdHNOvxS2xpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907239; c=relaxed/simple;
	bh=tbEVeD3AUoa4QJIvKiIKkH/6O5vag3+En2T9WmWoaUI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=VvzL78OMk6fX3ave5GYPwDkKvgi5wGcR00HZWUMCq+eAm4Hzr9+9qS8B7dvSVop80QIvP20qGwWj5mf+UYi8o4lxD9JA/fPv9y8JSXIP2xeBWm7RrEgtZKpIwwKgWAlLsSQcgU4S3T9CoZ72X09xWjLQNsT5iRXSgKHM54VCqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih7/8Gea; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-417f7edf87eso4965235e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712907236; x=1713512036; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frZY594kWfIMrR/24RGxK2/1/2Nf7qSOc8dwbXPUe9g=;
        b=ih7/8GeaTyEVuVOqMywCi3xdw9TCbYSvs29qumFokYdlTYr5g6bx0zObFaN1SUSr1W
         KIS9/2CHu73hrhcloSyT2rrEegSqdjh5wuN2tCeyHn/rSNmIC0zemevYR4AqQTu9bziW
         rJfuT4YfvJ0faKC8jiU/aoCoKDTbjLeVTs37wgsexAe5c2AyGlhm17PiZ91Vjh3ImDvM
         d3lgFV7IEyKAXYbBwaWoOLu2YTpn7WHjMpHqkGMjW2MsFoIReRPuMVqidimeJQ9Lbilt
         ajSJJZAlxHEM0j8VX43AfgnKSLJSrHApTtiV3bDo015Z5/gjBiJFiMY0SgCuh54eoAIU
         MA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907236; x=1713512036;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=frZY594kWfIMrR/24RGxK2/1/2Nf7qSOc8dwbXPUe9g=;
        b=DtbJWl/euoN+glQtJ+CDXfh3SPjrzQFwmVYFkTz3Xk4WwHFeq9xkKYSLiFOoI+WKci
         8nqQ8Qzvx8V4OkqGUYcO0GvbkwDOg1/7udI3Li+BUY5lqKGSmkEJe4cZFPcKQeWrKmjq
         9iAWbkPFdc3crnCuHPNwmb9X2CNbB11hnR+vm9nT1PM3nVszD3qCqtc076stTvitNbQr
         uR3Qiw4k4lkhDUgsPJMIa1hxaPWYM9QCViwXwSszPVAi38jNpaUdleul4rSKGgPcXqkB
         q6S0RnjEIjagCCYdXuYqJHLOeArnJTbcBUn4PZ73gcY4cyqm5W9kTRZ5UPJma0YUOwwN
         97ZQ==
X-Gm-Message-State: AOJu0Yw56Nt9SldgQ+1Gj3gObHvrG5/P0WnJfgNsdKmhrDHlGjOtuWpa
	hHpwBECO855/t3zs2wrLD15TYtufuC/sArjnsN7CvdC6XTVm45gyW2jIzQ==
X-Google-Smtp-Source: AGHT+IGrAwUdIyE2YxA7H0TGYK6EyEd19afc7TvtjYj8dcewHihSdOEdHE3HFvT76xHeF5kgHBJuMA==
X-Received: by 2002:a5d:5102:0:b0:341:dedd:9726 with SMTP id s2-20020a5d5102000000b00341dedd9726mr1208837wrt.3.1712907236296;
        Fri, 12 Apr 2024 00:33:56 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b00346c0062b0dsm3212945wrx.11.2024.04.12.00.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 00:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 09:33:55 +0200
Message-Id: <D0HYXSPMY8JE.17YSACO3ROKKZ@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "kangyang" <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: add support to handle beacon miss for
 WCN7850
X-Mailer: aerc 0.17.0
References: <20240412025149.1211-1-quic_kangyang@quicinc.com>
In-Reply-To: <20240412025149.1211-1-quic_kangyang@quicinc.com>

On Fri Apr 12, 2024 at 4:51 AM CEST, kangyang wrote:
[...]
> @@ -5986,6 +6055,20 @@ static int ath12k_mac_vdev_create(struct ath12k *a=
r, struct ieee80211_vif *vif)
>  	lockdep_assert_held(&ar->conf_mutex);
> =20
>  	arvif->ar =3D ar;
> +	arvif->vif =3D vif;
> +
> +	INIT_LIST_HEAD(&arvif->list);
> +	INIT_DELAYED_WORK(&arvif->connection_loss_work,
> +			  ath12k_mac_vif_sta_connection_loss_work);
> +
Is there a need to move the following part ?
Isn't just adding the delay work enough ?
> +	for (i =3D 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
> +		arvif->bitrate_mask.control[i].legacy =3D 0xffffffff;
> +		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
> +		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
> +		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
> +		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
> +	}
> +
>  	vdev_id =3D __ffs64(ab->free_vdev_map);
>  	arvif->vdev_id =3D vdev_id;
>  	arvif->vdev_subtype =3D WMI_VDEV_SUBTYPE_NONE;
> @@ -6316,16 +6399,6 @@ static int ath12k_mac_op_add_interface(struct ieee=
80211_hw *hw,
> =20
>  	arvif->vif =3D vif;
> =20
> -	INIT_LIST_HEAD(&arvif->list);
> -
> -	for (i =3D 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
> -		arvif->bitrate_mask.control[i].legacy =3D 0xffffffff;
> -		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
> -		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
> -		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
> -		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
> -	}
> -
>  	/* Allocate Default Queue now and reassign during actual vdev create */
>  	vif->cab_queue =3D ATH12K_HW_DEFAULT_QUEUE;
>  	for (i =3D 0; i < ARRAY_SIZE(vif->hw_queue); i++)
[...]

Thanks

