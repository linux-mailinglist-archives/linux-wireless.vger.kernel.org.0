Return-Path: <linux-wireless+bounces-24909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE0AFC437
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 09:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FCA7B2F21
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668AC221DA5;
	Tue,  8 Jul 2025 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MswKDH7M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D821A428
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960219; cv=none; b=n6e9nohdGS5bAwa3xgvu0UyAF84jdOdC23GzumM34zHF0Ne+EG3huDfCncqRuLVKT3E5VqgY2hljpDsCaH09zynI9ieXqaS3MSyXDCVrk5K7JeQgyVF1cZcvKDs41p4aKi1PwkAryFGYhSyy/NEgaO/NPjsYpzBKRG9umRoHsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960219; c=relaxed/simple;
	bh=eqzMASzsqKvWB8H5RXjaYwp+u1wfwIv4Kyx0OnUE+W8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=p9VZ5gvn+edCUjA4buMK47/73C1unNGzhF1PlRLgTOjbYMt4qdh0JP3fiLsSxf/V4NlEDJYJkamh00xnJIGsOeshmBVMTg3eCxgD6k4ex/VeGH0HfFedg13kaCYysZ7s5nOu+zZ2ap3YS84x03YN70AoM7RmXstmcsoA7hG6SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MswKDH7M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a54690d369so3905045f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751960215; x=1752565015; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNVCTZGIclUua5aJFaelM1CN9lMCU6duySJ0T/o5KMs=;
        b=MswKDH7M4E/NKD96N8bVHXkHjUJNvNLdmVuOj2gS/GQNkzLrD3zHvAV679lon+Ge+C
         1CzrlXiym9kSDamux3Y8pMxrRm0JM1sD1xcYM/q1AsqeN8CbfafWNc+hMPW9KiyPSosY
         ENp5qTuShdSLBxVfo/b3wlOIzewkLl7n1fPNNVVFrNocKpyMtXINDwT+mjrtlOeuolO/
         Gq8sMalGM63QQjPDXujqz18FqM3oZxArwJEcIoHXeRI4H4+W3n7Ad/8HWk3AIeaG1Eo8
         7w745Vk+slUQK/U77LDZwkNMx2aENvHUOJZzJEJvd/jD5PLw7F1brng7zXIP7AGzb9mn
         Kn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960215; x=1752565015;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jNVCTZGIclUua5aJFaelM1CN9lMCU6duySJ0T/o5KMs=;
        b=bwuhnqelZ0RtV+XYgCTB6AeOxQvdFBAAYg+hlcsd7+4a7EgMRBAJvnhgskkkdZ+aZ5
         Wg2Jp3pjWf+SRenNO5G43SithsJ9suYaji4RdtbSvmM6791fw555GkP0ud6b+Jy/EZ9I
         khNXvpG+AeWcmjOTEmLJms47PKY1fwQDWK41AEbfO7bc0X9do2Rh9wg+/4He7WT/nloa
         mudfnlvtLF/zTukSnxmD/YtdIYB25A61FQ0HDG5KTa9n6pNDUe+ebQ/dTpKheJWdsxrL
         jx0J2Z6/7QSHZ5wiWki3TCUzgUD5Iep2o/kppNlkfl5wcCJoaB5es5Sa88jNjYHy1CS7
         2lVg==
X-Gm-Message-State: AOJu0Yyj+HOMkmVYSGjikhDiKbGXEEO8ySHAJsLjEjW3WkjK+ais8wsJ
	id39gnb5uXM5ToHMxfZfLfW4t5EkGL2+puTZTSowwTaQDjAhmPiLbKaAB45EAw==
X-Gm-Gg: ASbGncu1URe0Fgk5B8VK/tfHFZURbUL7asNwuwTQMdgHwSzYfBif5plUSXfI+keGNEp
	G13yrhTQ6hybEzonzopCtsNQe9lvGVMD8tHMc/TMG+hQEdZD180QB92qUrwesHoeEMoO3M7h13A
	mR+GgDlnV5fbfbth05I3sq0r44q6ADNYbPKy5NovLF4DemTcipOy2glVpAc/yaTLJjh8Crf0dUs
	PE9h3ZuiVbzQ+nH24f4nFm6pcIM+/CuRHpxr3EjE5/L8dBblW6gzHLsKoTbxz1DDfjTE1/9ZBQ3
	WLCdvdT3k32WWWSEg253GdHzW5zsUBg2vFSMsamXdZkkl/Nw4FvgVt+q1BIRouuPsvybDRkyB3N
	/ddKj74jFSW55wWc=
X-Google-Smtp-Source: AGHT+IGbc5m/A/lUy6Z44xUNmJwgghVuoXq9qnyycnPtnXCB49G3ggRKXYqVhqCYFLBssz+XP3iupA==
X-Received: by 2002:a05:6000:420d:b0:3a3:7baf:f06a with SMTP id ffacd0b85a97d-3b497029578mr11689711f8f.37.1751960215112;
        Tue, 08 Jul 2025 00:36:55 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cdb31d21sm10726945e9.1.2025.07.08.00.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 00:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 09:36:54 +0200
Message-Id: <DB6I2BHTWU0B.1SV9BIHX8WRZY@gmail.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: support average ack rssi in
 station dump
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>, "Sivashankari Madhavan"
 <quic_sivamadh@quicinc.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250612114620.1055840-1-quic_ssreeela@quicinc.com>
 <DAKJLG9RLFCQ.3H8XQHL8ZY3GT@gmail.com>
 <10d52ab4-a0cd-445f-a23d-9396904b10df@oss.qualcomm.com>
In-Reply-To: <10d52ab4-a0cd-445f-a23d-9396904b10df@oss.qualcomm.com>

On Mon Jul 7, 2025 at 9:05 PM CEST, Jeff Johnson wrote:
> On 6/12/2025 5:10 AM, Nicolas Escande wrote:
>> On Thu Jun 12, 2025 at 1:46 PM CEST, Sowmiya Sree Elavalagan wrote:
>>> From: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
>>>
>>> Currently, the ACK RSSI value is not shown in station dump. Enable WMI
>>> resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
>>> management TX completion event from WMI. Update ACK RSSI value obtained
>>> in management and data frame completion path to ieee80211_tx_info. Also
>>> advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
>>> register to mac80211 layer so that ACK RSSI is added to station dump
>>> message.
>>>
>>> Example output :
>>> Station 00:03:7f:01:5c:4b (on wlp88s0)
>>>         inactive time:  46584 ms
>>>         rx bytes:       955
>>>         rx packets:     10
>>>         tx bytes:       769
>>>         tx packets:     6
>>>         tx retries:     81
>>>         tx failed:      0
>>>         rx drop misc:   0
>>>         signal:         -39 dBm
>>>         signal avg:     -40 dBm
>>>         tx bitrate:     6.0 MBit/s
>>>         tx duration:    1185 us
>>>         rx bitrate:     309.7 MBit/s 40MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE=
-DCM 0
>>>         rx duration:    0 us
>>>         last ack signal:-41 dBm
>>>         avg ack signal: -40 dBm
>>>         authorized:     yes
>>>         authenticated:  yes
>>> 	.......
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0=
_SILICONZ-3
>>>
>>> Signed-off-by: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
>>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> [...]
>>> @@ -5651,6 +5655,8 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(st=
ruct ath12k_base *ab,
>>>  	param->pdev_id =3D ev->pdev_id;
>>>  	param->desc_id =3D ev->desc_id;
>>>  	param->status =3D ev->status;
>>> +	param->ppdu_id =3D ev->ppdu_id;
>> Hello,
>> It seems this ppdu_id is retrieved from frimware but not used in this pa=
tchset
>> Is this by design ?
>
> I'm guessing it is for completeness (parse all members even if they aren'=
t
> used). Do you think this is a problem?

Not at all from my standpoint, but I just want to make sure this was by des=
ign
and not a telltail of a missing patch.

>
> /jeff


