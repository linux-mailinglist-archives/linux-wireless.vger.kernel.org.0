Return-Path: <linux-wireless+bounces-9425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCB912093
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B8E1C20A62
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D3377119;
	Fri, 21 Jun 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B2TRoZlp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24383CDA
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962215; cv=none; b=oD2gQq2oxtXaoAN8ZG8KfgTiaKzsSBdYJNiBwgxeToB9s/BTqs7CRhSDw3zFgg+TFVwTgx24pmBxWuF1mI9Os4a0zQyCgNixDsH64/kKW6nIADeIO3UPCQBSYdtj3odUkad3XOd4RP9jnzzYE257rKMUUSxppY0XCH4WEy7WQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962215; c=relaxed/simple;
	bh=l6/YZMi1PRGyzwGqfPMZsqRzJZeRppnMfWSGALa3LgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPMZ8coLqOUHAUOuo7YLkzN0aYWTE80iuPiUE9SSJFySXp4fXOziAgn56E0ZzZu9wcCPFzR0aO2exzdDS3Fdn30ViKNsB/qMmdZeqdKS5HWqhCZOzY2TT1/BuCjW6Z8+3EfzvvALzfVRb6G8VvrsVmwv8JD6Bi6bNMmyb8O50io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=B2TRoZlp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=l6/YZMi1PRGyzwGqfPMZsqRzJZeRppnMfWSGALa3LgI=;
	t=1718962212; x=1720171812; b=B2TRoZlposlilXplFHaVzTTSSk/24ICEGfJSQboOfP5q8bY
	k0chIGQuuLN2NOyP7WoibLwa7vdCOzj21wadH4WaVgHZbrX7vi7bUl8RVJFL2kofhs6LrFUH2Y5hZ
	W8vabNhPs68NxqVDKHMCsil4cM70qUHgWH9ao99Kq0cYyTPrVWX6T00Rs2WVdPdrN38SfdbppahGW
	sTY5aib3SeZk0gj4SpQGkUpm6yeZu/pwXN/gpRKFE5KeOgOKZXRoLG84YK7jlA3JTivwGf1uLHw4f
	0PQ3zlbAnJPY9YGR18PV0bFJuaquRtQT9ZBrpjZGUf9Zny2I8aalTET7iusiyrZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sKaav-0000000BjuR-0ohh;
	Fri, 21 Jun 2024 11:30:09 +0200
Message-ID: <83fcb33e3fadb457466126255297899fbc4186f8.camel@sipsolutions.net>
Subject: Re: ieee80211.h virtual_map splat
From: Johannes Berg <johannes@sipsolutions.net>
To: Koen Vandeputte <koen.vandeputte@citymesh.com>, quic_jjohnson@quicinc.com
Cc: ath10k@lists.infradead.org, linux-wireless
 <linux-wireless@vger.kernel.org>
Date: Fri, 21 Jun 2024 11:30:08 +0200
In-Reply-To: <CAPh3n834eg1_+gmh_LMTQnc95aLBWNVOANjZsMap=_szOY2nHQ@mail.gmail.com>
References: 
	<CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
	 <efc8cdc0853a921ce4dad1a36b084608fe0b01a8.camel@sipsolutions.net>
	 <CAPh3n834eg1_+gmh_LMTQnc95aLBWNVOANjZsMap=_szOY2nHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


> will this one get backported also?

Why? It's not even a bug.

johannes

