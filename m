Return-Path: <linux-wireless+bounces-6234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 412A58A2B1F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 11:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A03B21850
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D252F61;
	Fri, 12 Apr 2024 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfM5pZvU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952454650
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913827; cv=none; b=RpvspHy8eGaIoT6ts6WBDv3a3aH7xxByXFiWqVnJXknu8zD6FvjbsCVX5/6Ms60wwsWR/1zfXDypzERdoo7v55uNvQ2+aUdQFLyZjkIOyjrIcZK+z6F0rqS5LMBkayI3QPdyBsG0dn2GeJuUmQY8MfZkqGJpBFqQKq5eigucFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913827; c=relaxed/simple;
	bh=7UXVghcgcMjURurQ2igNhy01eq3tNyxUGlr0/MXH2u8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f/KUiMRIkn9s33eQxleSjuCmkXl4tWpcTKwYK/g4ZtmSlthAUDzQWH+/ZMKA78A3mCH4VZdESUtj0/2JnTf33O1+PiNTN5dmE3F56BobR9VRvkzXTLjXOh13QrWeijUOm5TCYzR+dGgP7Bd5SQvB2z9mnpO3upx0TVRglTzO4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfM5pZvU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso461504f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 02:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913824; x=1713518624; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WK4hlBESstsIUX+zMhngFDheN5gnJTFx66i5y0Tzm4=;
        b=IfM5pZvUyWBYFndBuUsdQPzwdinAZ/AcpZOJe9kAqLHWMC6R3+24/Em7r2BRvGpJCh
         /jglvTHP9g0BZ2a5JZtSOBySIYVskjSEc5ai8Wh1uyUhIWimZXO8HulWlE0hhPPtV1b1
         BoZbcShGUDtizCCpjyVjviAIPdfOFFMp/iZvGnQpGA13dcSHGluJWkpylc4gKGcjmkx9
         rsLn4WJJ14WlejbE2KCWFBPfCPu4zXFo1PHnZgCw5Of0qD8q6qm/ObnJ28o+hBg48nC6
         ZW4gHOizgTaIKD8lukOh8QoCe+cktzvkfLCcAg/5ObuFMhnPfqevpPDXlTzTaKum6E3S
         oL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913824; x=1713518624;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5WK4hlBESstsIUX+zMhngFDheN5gnJTFx66i5y0Tzm4=;
        b=WbyqeP7E/S65kQKinch2LbGyT/EWYOHAiYC7cOF3AKsNGA9ft9tmOdZAKamJvlyB6A
         faXHya+4OPEDTYLApYGaxM1FzukBc21ExNJWVYbX/59fnaqbBySLG9NmkQfZWXOrH42y
         WvPEf5JKG7A5gUg0cliuFlVVCHlEh37nBAgHK3N8CpQiJjfHnrFH3D3YJh5FRMEeS5uI
         6T71b5o35oqRZeN4+tMbn54rtLulBgJWS+36SILj3SAw5qnIr0gdz5lE6XjXTzyhZgwH
         tu2mi3ZJTOKK/qDY1I5jL83h83KliwWJgRJ8SqsF3BH+ap3QW8ma3UP8P9WQESABXdnQ
         hKKw==
X-Gm-Message-State: AOJu0YzEtOTUoASxK4PRM/dbCRzlrjN/vm45wCYuV4HKG0vLpZnkka25
	Z5nz319mPAFlPzAmw9wYmuIAxo9sxuXxSjE2d52qd7clfJD0WJt1RsVBZg==
X-Google-Smtp-Source: AGHT+IEfd/dQCgUdBpBoWhvCRuRFjBhFLkkyqmM/3BxuR9AAjM3dJ0VKTDcop11fx5p2PgRYfU9Tjg==
X-Received: by 2002:adf:e2c8:0:b0:343:6e18:5f09 with SMTP id d8-20020adfe2c8000000b003436e185f09mr1261070wrj.12.1712913823801;
        Fri, 12 Apr 2024 02:23:43 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ea15-20020a0560000ecf00b003438cc1d2b4sm3812598wrb.59.2024.04.12.02.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 02:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 11:23:43 +0200
Message-Id: <D0I19V0104BZ.IN8THB2XCFLV@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: add support to handle beacon miss for
 WCN7850
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Kang Yang" <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.17.0
References: <20240412025149.1211-1-quic_kangyang@quicinc.com>
 <D0HYXSPMY8JE.17YSACO3ROKKZ@gmail.com>
 <6ee5664b-997b-45eb-89f9-5f75708c268a@quicinc.com>
In-Reply-To: <6ee5664b-997b-45eb-89f9-5f75708c268a@quicinc.com>

On Fri Apr 12, 2024 at 10:47 AM CEST, Kang Yang wrote:
>
>
> On 4/12/2024 3:33 PM, Nicolas Escande wrote:
> > On Fri Apr 12, 2024 at 4:51 AM CEST, kangyang wrote:
> > [...]
> >> @@ -5986,6 +6055,20 @@ static int ath12k_mac_vdev_create(struct ath12k=
 *ar, struct ieee80211_vif *vif)
> >>   	lockdep_assert_held(&ar->conf_mutex);
> >>  =20
> >>   	arvif->ar =3D ar;
> >> +	arvif->vif =3D vif;
> >> +
> >> +	INIT_LIST_HEAD(&arvif->list);
> >> +	INIT_DELAYED_WORK(&arvif->connection_loss_work,
> >> +			  ath12k_mac_vif_sta_connection_loss_work);
> >> +
> > Is there a need to move the following part ?
> > Isn't just adding the delay work enough ?
>
>
> Just checked, you are right, but should add delay work in add_interface()=
.
>
> Will change in v3.
>
>
> >> +	for (i =3D 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
> >> +		arvif->bitrate_mask.control[i].legacy =3D 0xffffffff;
> >> +		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
> >> +		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
> >> +		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
> >> +		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
> >> +	}
> >> +
> >>   	vdev_id =3D __ffs64(ab->free_vdev_map);
> >>   	arvif->vdev_id =3D vdev_id;
> >>   	arvif->vdev_subtype =3D WMI_VDEV_SUBTYPE_NONE;
> >> @@ -6316,16 +6399,6 @@ static int ath12k_mac_op_add_interface(struct i=
eee80211_hw *hw,
> >>  =20
> >>   	arvif->vif =3D vif;
> >>  =20
> >> -	INIT_LIST_HEAD(&arvif->list);
> >> -
> >> -	for (i =3D 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
> >> -		arvif->bitrate_mask.control[i].legacy =3D 0xffffffff;
> >> -		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
> >> -		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
> >> -		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
> >> -		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
> >> -	}
> >> -
> >>   	/* Allocate Default Queue now and reassign during actual vdev creat=
e */
> >>   	vif->cab_queue =3D ATH12K_HW_DEFAULT_QUEUE;
> >>   	for (i =3D 0; i < ARRAY_SIZE(vif->hw_queue); i++)
> > [...]
> >=20
> > Thanks

Yeah, I wasn't clear enough, I meant adding the INIT_DELAY_WORK without mov=
ing
the rest of the code around.=20

Thanks

