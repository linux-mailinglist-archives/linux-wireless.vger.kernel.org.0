Return-Path: <linux-wireless+bounces-34933-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKmTEsc04mm13QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34933-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:25:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 074EB41B949
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1449303FABB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168D399002;
	Fri, 17 Apr 2026 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TchIWTHO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AC7262B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432297; cv=pass; b=KJjSLBV3EoYw917uwLmL7yWkq8GUIUO+ErJkEmJO0NNUj+O5OrMGdD0uOCBv0nLV9VByEbyoAWHKPEYsaho07w6cGm/hIMgY5ul+N5ZllMv08tjX9gCizZ9Gg+0DB7+ZYYkRwAbs39Ji8BD4daKEr2kaVjTexCiHL6N1cRZ5z8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432297; c=relaxed/simple;
	bh=6huK3CuPiSQw7SSTJdpX/atPd5LM8RlZ7louFQb1Zw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OYSf1EWpO2mxaWNeqOvcFxhT3FimxG5gGqjD4LYiSJUBbilHWukMKgYRs/0I8yKFztBQ6TKc1Jejc6mf3HoiK9gkvZ8HSuuHYwTuFTrT1hdFL01CPHAIY+F6NVIi5ypTHVTwuDDsu/zyv1zOAIUI6lAd06v4/gCL8JIulmQlGOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TchIWTHO; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c79467f128cso267722a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776432296; cv=none;
        d=google.com; s=arc-20240605;
        b=NXR1u6bkpkwiyp6u6K3Vle7e9qHhZyLr5l/BVc3VZDTz3Job3RZ5+ksUorWLAFuUci
         yDJPUr1Cf7rjjvLlpqcIQAR2oX+prBLXmQ/FYeB+6Uh3N0JT9OwE0ILs1wSIjxyDLtKC
         Xf87Oa29UYJuMMhbkqOrxLKzC7Fp2+/UUPxh28rMY+2enuLh/7MkJLM5uSisf6T4SiIw
         s3xJftjskuKAP57gash85xncuVBY68aFkA8ULZ5a1L94Mbz0OSFGxF23w/n3LWBXivvu
         pgOl5Ojw44lyPjdVVmwZPITe9scW5aS/enpxAxJyTQrFKfh+RtbBOh4RHonx02El2AfM
         lBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i73oHmYIAOQUbtL6tiCKTDg/Y5KhFaeudJ/xwSdJpAg=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=FtyumKfZV5q3m4KF9rXCGQOa1b2opJroaovig2vG6CR0n8vhzmR+gHCdSJSRrP3EOd
         /NJVBJ2e8kGSvH+/buDoB8+8roywOKEgi3VGQwghGYsjXvfVAS0fAbomveyWNwt+gojI
         ZLUNRTNjBAA7NCbDImW0BaNfivME8PLxzyN2Sl0GksRpsOmOqla5XLAnYoWCGYli5nEB
         s6vTvFNi+egrtt1mHaVl0udHhckvC/9QE1+xo+nOtkoERqIrsYcgy4JVsZnFW1N1ogjl
         HVhd08XeUaeoGz064OfRuuyGJPlFkcZfW86yfpp8w4Zpgn9n7aJwQejim6+OHqKZqlxW
         VUyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776432296; x=1777037096; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i73oHmYIAOQUbtL6tiCKTDg/Y5KhFaeudJ/xwSdJpAg=;
        b=TchIWTHOOrh6RTjGqT/WjrURn2SUT1y+6B7JRD13VtOI5JRARHd20KdexpScwxmmCi
         mfq0CIDLqeZgjrmsRIB0D406U7nmVKBlCWvuxN190Pb441UYzY7ZzYWz44Y6It7nsFd5
         LSvmSSz456ca7QG74NgtmiAzuSYgKar4SSIyuw+PMqImYWxgI0RgM5l/Dp3MTTqLb20k
         CKONH9VvddR5BHUYbVfplEiC4bm0R+KBOAQ0mi+RtmCpNpQuJHazVmWBXZ6SipApcSF/
         qtfytzAZquU9vKZCiLh17ZA2x2ugUubRlFds7DD0kx0/vBdBGPvwYTJRnKLZbfYiVrUI
         HVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432296; x=1777037096;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i73oHmYIAOQUbtL6tiCKTDg/Y5KhFaeudJ/xwSdJpAg=;
        b=lq+LPUKOJo3Nlmi/E8HM3M5HCf/IeKt19qmbN9esDUz4ezQ66u3IsGtrXGztC+YeN4
         EX8l43q3DEuOUvx0LkPqwNHm3nk3I4uYBqeQU3CJZITS4BWdpa6v7iimBvFZi7qekZPt
         3vxF3l4ewN30degmpsv+XtG6Qdca5X1GBp73frHiG1jF3c9QNRrdcIw9lvIK7F0YDlDI
         fGw/9TtipCalVLR2urp28we/UnwcW1KJnv4lmHrL1U3vGhtcxLaxpC1ySru21DEfy4Oc
         kHc/EWdfFj1DArQ8GRg00FGjN5dNi+m2YtzKwtq9yKJ8q+AkF6qNYAe1O+GWmBEAqFr8
         /uxQ==
X-Gm-Message-State: AOJu0Yya0ksgU36rgSqmFHqog78n8eNyqWWDOdzj3J+fIavAQr6K/3lN
	Xw3hQgcgD6lB0BAOe6kEjve8+n/N1ogD0qpF8t/QqYi5jbp8GymOfBqmy+JTytPzelJVLIbuZsn
	dZRBKG+lhy5duoo+k8ELUwe2Y8FaflN4mQnJ2GSQ=
X-Gm-Gg: AeBDievh3yIfS80XHy872snKyOcFnKGCe22ArCHsTAWvptT6Hs1f962/iMdIum7VIIG
	9WyknyQfTPrDCSBPCurC0+QhscTDwK3DHFNbnWSQ6eAxHwlwalY9hEFM9YPOkEnphAE8CjyBmHA
	6c34mrt+sXqydn/qypHTkXQLXD8CgXbu2VcmEIrF9Ig2MKrSp/EZXOrtuLXIaU6tXNs1j+MgxMR
	FH8CbbQHjEpSAkWvPVTQB2P1Wed/lOjuyisg/mlmQfFr9S6Rhcpqx0qTQTYKqq4aSvd8uLzDqP7
	vLSzLba0tCSkYzgACuRSqUOyBLhIIEZX
X-Received: by 2002:a05:6a20:729c:b0:39c:bf48:11db with SMTP id
 adf61e73a8af0-3a08d8e0785mr3158964637.38.1776432295609; Fri, 17 Apr 2026
 06:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
 <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be> <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
 <beee4be9-2bfc-4c38-ad1b-13ecc7d90aa3@eskapa.be> <CACM6vn7Dau9cX4tUCVQZmEpRmd7JiNtALUfR_fFARMbR_VZ_7A@mail.gmail.com>
 <5b3d8cb4-13a4-45ca-8ddc-0692ace0488b@eskapa.be>
In-Reply-To: <5b3d8cb4-13a4-45ca-8ddc-0692ace0488b@eskapa.be>
From: Benson Bear <benson.bear@gmail.com>
Date: Fri, 17 Apr 2026 09:24:44 -0400
X-Gm-Features: AQROBzDzM4r80OyWgl5g3kUwn08PqU4nCTo8XKaMLnOKxUOcdTEr573Pp5hbMjs
Message-ID: <CACM6vn5FpHycsv6=bUwP2yBmV_an69zTgsJKJPVdewz4cnv5sA@mail.gmail.com>
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-34933-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bensonbear@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,eskapa.be:email]
X-Rspamd-Queue-Id: 074EB41B949
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 10:03=E2=80=AFAM Pablo MARTIN-GOMEZ <pablomg@eskapa=
.be> wrote:

> You have dig slightly into 802.11 standard to understand the PMF
> negotiation. Here is a quick summary:

Thanks very much for that.  It shows me how the STA can be put
into a bad place by errant AP behavior.   I will try to get the
information that will diagnose this.

But I am having some trouble setting up the monitor mode on one
machine to grab the packets produced by the AP and the
other machine.  I can probably figure it out and once I get that I will
save in a file and forward this  file after I try to look at it myself also=
.
I have to work at this in little pieces so it may take a while.

On 2026-04-16 09:58, Johannes Berg wrote:

> > Not iron clad, because maybe the AP is just plain crazy.
>
> My bet would be on that but we'd have to see a sniffer capture. But in
> general, we definitely know that PMF works with Linux/wpa_s and WiFi7
> requires it, et

Yes, (all new to me but) it seems Linux has been doing this
successfully for a while with all manner of APs, and the
Rogers/Comcast XB7 adding PMF capability is rather new, so
prima facie we can suspect the problem is with the AP here.

I will try to get the capture but it will take a while.

(I see you guys are sending to the list and cc'ing me both
(because I am not on the list and probably shouldn't be).   But since
you are on the list I took off the cc so you don't get too many copies.
Let me know iff this is not the correct thing to do).

