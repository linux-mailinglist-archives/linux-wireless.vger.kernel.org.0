Return-Path: <linux-wireless+bounces-32099-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B7sMXUmnGlfAAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32099-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 11:05:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF2D174797
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 11:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E9FD303CC1C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC28350298;
	Mon, 23 Feb 2026 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL43Gl5s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5E354AC7
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841112; cv=none; b=fKtTPOltjRhxW+Ms6I6VI2eCh2ae7BrdWMCOHmFnhDSHn9pocT6iYbyC27j9/VXIXoQGgsszVQxELutJhOrhMidFgpO2oN9BfuwlZ2JIBKENxZoNxQnqvN5WnBuUcc4brllFzUqJH8C6iyAiewkW+/HoiiRPtaLnRLbeq+AQ+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841112; c=relaxed/simple;
	bh=SBZcDxpIEa0k2LbjATPXKoybIi7qV2+ghuFMxIyL8mU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZZJXN+qFGFotyU+1Od89WIx/iSUJ26/RuFfa0yPcV9UTLVCwrq5lFu7wYyEe/wB7yYJZzefLK1hXBgy83mOj6g3Qr5PFj+d+4rq6ILL+OzkFb6wEMq9MF//szTZ8smW8bnJv6jzxMeC/aOAVDc9hUcT2CFHDy3MZmH0711F/Fjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL43Gl5s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48371bb515eso52589395e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 02:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771841109; x=1772445909; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udDw3yBpUkAMkazROavv5PXUxzxBR+GjnS6pxK0vMWA=;
        b=DL43Gl5sjOClm+EzLLEfv4/ifsDtOF9oyiW85QcwC0vq2z3wBbAxc/7q8it8SQZZh8
         z7PW49EpyRTqdJDUA4cMXUD1ZJUmEx9cQE1NQV0KHw7JEXEEMF3iEUEz5Sqnj4AK5bwn
         Yjjd/bPuYmqltuABNFnUCbnmSYWZvA43qD1e533P4wAYjerM3jqisLi6NBAjE7I2TseO
         9ZzrPzwCJHP7qIjgYU7hd6HBZU1xtIe4WS0jzsuXFF5sOWaGU+zIPwtkceXq/690OGdU
         B5u/S8YAc3yD4adLblCZvwxtSzJxvgplIZLrvBJWLenNpOHTP2NypSWJRm+IAIllywFS
         lkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841109; x=1772445909;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udDw3yBpUkAMkazROavv5PXUxzxBR+GjnS6pxK0vMWA=;
        b=GSas2IWapiHRUDkznm/FJcJY+WWC8DVSwdHbTs55fIycyzayCqaAS6wz5aGA70zh49
         XXxVYcCzIk3IoinIA5WbQVGNTlSA8KdYTVl3ydTFrAUWd2gWavZDC38RpqhCiswOdq8N
         9G17Iik4KSSckUn5D2+JVePEuj+L64GIfTo7ncTOSUX2M69M9kMj4h3I719JMELdkMLp
         eWtwe4gsBpaJwy4Hki9HQhYLLV59zS14kZaMoiP+ZXT8r6GYJ5M928WrKaqz4jkaYLwV
         SoSzrnBGxK2OTdkuwLgwWUPdbm0UHzMp7WCAiTlxrepBfjnCOs/Yhfr1Y/XozmswVsk4
         FHpQ==
X-Gm-Message-State: AOJu0Yx5s9e9v/75hV5me9u9+vhcyTEjv+Upk57aKiWKHL6erjVCgDh9
	ik83dfFixVciFuzcJFFPIVPRz2bMF6t2BVNER0AGU+09YTYsgYo1AH4E
X-Gm-Gg: AZuq6aKeQ7jMV29oSoNjwaqYclBTWkKUKR/r2qjdEng5VDki0J+/mT1RYemVLKvHRmC
	GlZbbQehjhGB8QjhBslVCDOZvJzy2x2JeEHpduqVix3xNAdoO3wZPsQCho30Gz9S3uRmwTqEm5B
	EucsnssxOCUFZ2s4muCrwyUH5nvfScF59q5UHAYH8WB+y3Ao+KTc2C+2EDe85cbQp/SYywvhn6V
	pJk4V91vNu7nKDSSqCtJmur/g+Aj2FfnnBNOwWV5WmJtJ71vnpjZ+5T/n627EouM6+LZxz+CNzs
	/RDDQfRplWfWeiKfc7bHGyTQJ8qEM+SmmUXO5gNb7stAm5fbFrp2oMsuZokDk0HJsqMQVil4wWS
	uPGbM4d8diR0EmfcSZwJabJ/XarvK1wXOsTSPdoYn7SweiFs2QphTvguYU4n1k8ZTGtak+tpwfv
	DiFmHVFR+uWRhbLsKS7I3jrMN4d8wXJpTwRyIh/df3SA==
X-Received: by 2002:a05:600c:1f8f:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-483a962e459mr155134995e9.16.1771841109061;
        Mon, 23 Feb 2026 02:05:09 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54c5csm17737463f8f.38.2026.02.23.02.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 02:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 11:05:08 +0100
Message-Id: <DGM9946HTER7.2HAN0CPP3R2ZZ@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Maharaja Kennadyrajan" <maharaja.kennadyrajan@oss.qualcomm.com>,
 <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>, "Aishwarya R"
 <aishwarya.r@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v3] wifi: ath12k: add basic hwmon temperature
 reporting
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260223060238.7038-1-maharaja.kennadyrajan@oss.qualcomm.com>
In-Reply-To: <20260223060238.7038-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32099-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 6AF2D174797
X-Rspamd-Action: no action

On Mon Feb 23, 2026 at 7:02 AM CET, Maharaja Kennadyrajan wrote:
[...]
> +static ssize_t ath12k_thermal_temp_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct ath12k *ar =3D dev_get_drvdata(dev);
> +	unsigned long time_left;
> +	int ret, temperature;
> +
> +	guard(wiphy)(ath12k_ar_to_hw(ar)->wiphy);
> +	guard(mutex)(&ar->thermal.lock);

Hello,

Is this mutex really needed ? It is used in conjuction with the wiphy_lock =
but
it's never used elsewhere. So even though there can be multiple ar for a si=
ngle
wiphy, there is no code path that that would lock this ar->thermal.lock wit=
hout
locking first the wiphy. And the wiphy lock already protect for reconfigura=
tion
and recovery right ?

> +
> +	if (ar->ah->state !=3D ATH12K_HW_STATE_ON)
> +		return -ENETDOWN;
> +
> +	reinit_completion(&ar->thermal.wmi_sync);
> +	ret =3D ath12k_wmi_send_pdev_temperature_cmd(ar);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to read temperature %d\n", ret);
> +		return ret;
> +	}

