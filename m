Return-Path: <linux-wireless+bounces-15782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 367D69DB795
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 13:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DFDB20936
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217C19D092;
	Thu, 28 Nov 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SR+2143n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078019C560
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796937; cv=none; b=PZ4zjg5kuI608SXS7lEfsU3YCO87+/3hkeEo88fw4sBc0cWTOJV+aMaY6gZ6SH7FPiJhCty9NgZLQup9AxYPEnnwwgbzmd7W23CwpFJyfw9/p4AiBeAp4nCGniPTpIZ+RhIOCsY2xy21jmxwPxM9ngAjPwEZ5MY9pAbE3v/KrsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796937; c=relaxed/simple;
	bh=7YyGrl4KoRmc0JeVQNy93UMWTak4tQ4PB7z7wqFR2wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h78Kww+S9CDrsLeX8M2bzE97FXq1Uygmo4e7/ANK0pRl1CSiSBkrhb7TAbCi/zDnuWQUf8CIWoFBkAw/u6kz9BOnc8jYpe4ooXBPZWwV6MZiWpJengDjeUvoqpkrffcUZuct1pQxKtoMpbYSKx9BEwnW3PxPp6XAPXeWpO+TlLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SR+2143n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732796934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZACMslqIaF7iVtmlx12c8LPoSlN7TzLegXngDuX2z78=;
	b=SR+2143n/ny/c1ljGZjDnEADm/Ip4JnzZKHEGegX2fSpQuWWcE1/kNzNUvhvIvpffUaami
	pQnV8KfkLGfnmwFF1tW7gB4vxoTu6M1GGF94HZMZeKWCvFMHdHksmJydcDHl7j7pLyw10t
	usmZaRSuxFMIGWqNTbACv75cFVGLQL0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-K3JSF4JmNLiacHc4BxjYVg-1; Thu, 28 Nov 2024 07:28:53 -0500
X-MC-Unique: K3JSF4JmNLiacHc4BxjYVg-1
X-Mimecast-MFC-AGG-ID: K3JSF4JmNLiacHc4BxjYVg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d6ee042eso94041f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 04:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796932; x=1733401732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZACMslqIaF7iVtmlx12c8LPoSlN7TzLegXngDuX2z78=;
        b=RFQ48zw4qKMo04FGPlu2usTDPKSi40JCCd+7+ZpvA3Gn4AlAOTt8mpeIB7eZ0UQ4RH
         VRL1GcoKKT88Vlq1H/TZr26bSxPfu6P+7cRXBmw9762oHCZucMjfn7LcHq5rySP1rrxS
         9oWL/aFDkck0vuOnNMORBgYcPUVFOYB1+WN/TmGXR/kG2zzgx4oAjdCRuFw9fY31uYhr
         MTxWMEgtYNoEVG0HSmX1fecjDB9Dd35FHPrezepw86ivqRnINLS5khgyU4NDv0yQ7VzG
         XXdyEUHS70R7Jm2nxgk1s6bUbKYykr5tWNLv22Z9be6NtFQSCpYykN+Sjszy2utPAQ6h
         VIFw==
X-Forwarded-Encrypted: i=1; AJvYcCXSAl5KTEi1+HKb9xgngp2ndgXrxusPl3dPzCqODy43qHdPWVO5Lr7snMYxwt2KJsTODLEY/3aewSAvFpcR2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOx4/En1UENOZwBZcNtLMfOvGV0NifiJ8pKfnjmVHEBLdBeJUO
	MMiRtEAonlXZIH8jqRZWGnacMKN+f7LFR5KnHOZPYpf6v2tGu2jYy3wzIDzn/FUsGnYTGsM/roC
	v7KGP0LOU39qyrsagcRXQkOJYuwMErzgvAWCWG1ux+BNiIulwOBkISRGbJ/jFIoD069RKZ+W9RE
	K7G57vUNyXVAs+lF7DGX17BaXuNg3zA4EcaA9m4Po=
X-Gm-Gg: ASbGncv1DwgA7rl1wGciOpH5vN0D4LkmxozC8cDIKqd8tHN/Jw39XDAk8xLj5A3iXsJ
	Ye48YuSxpXlbrlIgBM/LtAsHDqXXgieA=
X-Received: by 2002:a05:6000:18ac:b0:382:4a27:1319 with SMTP id ffacd0b85a97d-385c6eb5840mr5776159f8f.6.1732796932007;
        Thu, 28 Nov 2024 04:28:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGOqoP8tsZ6KQpRsoqtGa6KHF61EJ3NUmj3Aw3MlprtODTvHQ/TDY7uTpa3Nw0Vy2Is2RlK3QrcXMwzmVV8rU=
X-Received: by 2002:a05:6000:18ac:b0:382:4a27:1319 with SMTP id
 ffacd0b85a97d-385c6eb5840mr5776067f8f.6.1732796931576; Thu, 28 Nov 2024
 04:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-18-911fb7595e79@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-18-911fb7595e79@linux.microsoft.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 28 Nov 2024 14:28:40 +0200
Message-ID: <CAO8a2SgQ-==SjhDFZpi2s3r9FUGA96jwuJL7kTDwE=Hw4UcgUg@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] ceph: Convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
	Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, Louis Peens <louis.peens@corigine.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-scsi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-mm@kvack.org, linux-bluetooth@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, 
	ceph-devel@vger.kernel.org, live-patching@vger.kernel.org, 
	linux-sound@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	oss-drivers@corigine.com, linuxppc-dev@lists.ozlabs.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

looks good

On Sat, Nov 16, 2024 at 12:32=E2=80=AFAM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> Changes made with the following Coccinelle rules:
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  fs/ceph/quota.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 06ee397e0c3a6172592e62dba95cd267cfff0db1..d90eda19bcc4618f98bfed833=
c10a6071cf2e2ac 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -166,7 +166,7 @@ static struct inode *lookup_quotarealm_inode(struct c=
eph_mds_client *mdsc,
>         if (IS_ERR(in)) {
>                 doutc(cl, "Can't lookup inode %llx (err: %ld)\n", realm->=
ino,
>                       PTR_ERR(in));
> -               qri->timeout =3D jiffies + msecs_to_jiffies(60 * 1000); /=
* XXX */
> +               qri->timeout =3D jiffies + secs_to_jiffies(60); /* XXX */
>         } else {
>                 qri->timeout =3D 0;
>                 qri->inode =3D in;
>
> --
> 2.34.1
>
>


