Return-Path: <linux-wireless+bounces-7418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF28C1D49
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 06:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98833B209B1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EE4148FF1;
	Fri, 10 May 2024 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="HNx7Hqiw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4B13B787
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715313668; cv=none; b=KZDbAAwHYn9uYPZB3zL5xL8wOYT/9ZUCJneMGrYjEPxALfbSJzlDDnOuYwwnrp5FNl8aP2mzDaorenFc8CRM1YJ9vBybxWXx8bnNYeUwByfxAJZNzV+OZTiRSDy5sBGCL8w26JqopyNCYqPwwQRQMSp0EAPPyj5t92lx8HARcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715313668; c=relaxed/simple;
	bh=M1G7r012e6n5zovyPVqNx6Bv4jDpvhdDT8ew3A01idM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxE78HIldI/I9xX6EX1g0t8Yx5YijhqhVCdCHVXaVXLtOgzDRc+Y8o3zkthvhYx+p2m+5n4hn0m+L2O13bA+smNp4hglxEmg5BxC5Js6mmUBA5cVY1TIXjAhyLoisZ/9KCB8niegRikmdmffFiIT0FzmkWivwgxVq2MaLEYSBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=HNx7Hqiw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715313648; x=1715918448; i=s.l-h@gmx.de;
	bh=UG1tqtOgAP1Ly82+eG0co9A4S1kIyROW6FnNvdkQ2dc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HNx7Hqiw3/bpktyueUbk6P/8tmn9vM9cFdeidXthvBBvgLP5wBVmgBRNommR/0J0
	 PB8f327niV1vRTSYmWDIWmdLet09PT01+KwP/6ScWMQ3RVFXnWTWCLer/XBAJLhp0
	 YD8eIik18zAChbl8TpD1aDJ2I/hkMfKuDGsrhnBbfVxPTIhsFrl+Gps2r99l6rzy8
	 raZ8bD+HWYzRJIYiZlgPWcxWUQ7v+Y3neIrjZJOmx2JoHzrgawC6Q8qt+3s1CtC1y
	 pdpssteFNwkM7EXvhkQ60Xsa9HFEdMRIuxuSaM3vMPSOdZhzELEY4k8ixwRS8yJdK
	 A9PIgrY7N5FUQNuQpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1spNk00sbA-00xbjp; Fri, 10
 May 2024 06:00:48 +0200
Date: Fri, 10 May 2024 06:00:44 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger
 <Larry.Finger@lwfinger.net>, Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH v5 00/11] wifi: rtlwifi: Add new rtl8192du driver
Message-ID: <20240510060044.64870dfb@mir>
In-Reply-To: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rS/MdsvkMDZ+fH6F4N7Fwi9Q5QiaiHBEZblcLJX5FOw+dIGTLfo
 Qdq8GArTO7368Sydp7VHsWkwqOZ+n+gcj/49ayN8o31dAjgnNh1GdJlD2m8U6O4+MnGIXTn
 c28w/M4x5b38UTG+WfBm8MCsYwkQqIpXRlx4rgs8BQ0BZEKyLTypQktEJESiMzPYL8QMYt1
 JeFXh/kQys9EQQtJ2f7zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vSN3Jr/42BY=;SZvx84wdEEFTfo4plNqK1wZ2986
 4InP1J7bm26qXHlkhSXdLMhDTtou+EalqzmcCOxrrWav2qgknSAuBJb1D5piqbo0AxAHas1GR
 hnpRILI+rheUC44yWz1sKLUZ76C9jf7T/cBq1VyF+82kMe1YMNdFR+D/1twg9rhT5v+qp3Qb1
 D0z/cqen9nyF+lh3Ob/yoUjyrHoAhak9QwjowZJZYX4zEYsRs77Rxn3DfKXQrxwM8gA0cUoZc
 lXzwWPJTU5rnYNf6/xPAPVddrakaCsul+ZFZv5Dz5y38sIeF3Uw0ibyKZt8Wc8YA5Rt4I70tD
 7gdNEBUBVq2VNWeKXewHIsUvDgMdYfc3/TYpJCvDjTSFZNOjwluLV2zRkwao0ZToZC/s55CBD
 NiUvJySYys1QB2VkulmW1mbafbAxrO1DUUj/ejERb31v+71/cU/q5ijAtUpZN9zXOq/86clEM
 dCvyP3dAud0TO3sdR09OIZL7Q04b0cmfj44B5V62ZoX7YkpnjQ4kqiCu1Ybzsm/VGpPyHYxDq
 CZMb7lLVF+OTJ26rLm/0kYZRDgkW4WwLoUemgzqqMaw78OKMBYiGe/Pdr+GFaifFNcH2v7ylk
 qoNuJ3PjjABS3JlJb25ddqRskZNdOxcTUZCL6X7uw2TwiKxkk+Wy6M3Xu4ye5PKioYqXTWnxM
 Q3LPJfc+NSw2wZytcTtWrvF79c0uCbTpczCCSBQSh23rcPEvZpHpvM7Rq66JVJ+gRWZEiVjBu
 5v4HB3yQOUM8m1NA0Q4OpJX/40MDYeXL9AN9R524R3rdKYUY12GcYc9Hn/pHVULr2aFAnPiLj
 pPDtCaIWA5Wfd20PaS9fEuoywLAQe4J35nknf+UNupXbA=

Hi

On 2024-05-08, Bitterblue Smith wrote:
> These patches add a driver for the RTL8192DU chip.
>
> Power saving is disabled by default because it's not working.
>
> Dual MAC chips are not tested.
[...]

Just a quick functionality check with v5 (based on top of v7 of the
common code preparatory patch series), all fine at ~162 MBit/s
thoughput (5 GHz/ ch52, WPA3SAE, QCN5054 AP, ~3m distance). Steady
performance, working really well on my Delock 88540 (0bda:8194,
single-mac).

Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>

Regards
	Stefan Lippers-Hollmann

