Return-Path: <linux-wireless+bounces-33749-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAd0Es3kwWnLXgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33749-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 02:11:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D649D300546
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 02:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F44D3030EC4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A66363083;
	Tue, 24 Mar 2026 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PkMRA3FQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551530170F
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314549; cv=pass; b=BbQD7GRYVA5WPSAimrJUWWbeBAS//93YVkAS5JyuwOK3vyqYwnM6+umjikx2DkHqxUleowG/M+Ms7Aa26gAX4g+sBR4HSA7vHF+PhPm5KP15gVkfVBejiGiPFBDKFS1GMzmYCdzimAGhTFqeXytcZTwncHu1MkduFA0Lu8BIBKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314549; c=relaxed/simple;
	bh=Otgymp1urGzh3BWni7OReiTuagbbb9xFbODIFlXoXdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzvPm6y5srtt3EgT4bPO7g5y6TIvrWVCpN2zU5GfdPViHsh8jUlDQfHxyuwZ2XhLiD6/QljyJ3Lqc6zXXMtHdbp1iLoedEloDU6qrEObs2uFz1oPut+0RoorcSGGQKYvgXRQ+JK7ThwE5sdpTcbnLBBqALju2oalD9/N+o3gmCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PkMRA3FQ; arc=pass smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-1279eced0b9so4844612c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 18:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774314546; x=1774919346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10LYRv6BdbGuyL4E+Lq9YaOzMFLyGeYUTZxx5kY4YI8=;
        b=Z3MIBHl1pEkGBnBm2/d6Ci0YlIaCYIaEf8KzSP8gu6Ma3XaCIRI7AjxpBfpYYvbPSy
         wKDrzMSiFQsp7t83zTMPJmHsWhT16CtMqRUVAEBqBjPlN5exmlnXGuMR1+pxs1c/cfoH
         Oh1bTCB5NNO8CebjEXJ9wnE/7yle+9fNjdyiEWs8l94vVPKQAxcvCrOAYxL0eZoIRfGP
         JCpvMgwg0UOAJ1YAckmJAr9V99LYfWITQPw7ukKaqBV9PJiQj2iIv2k89j0oU3gxc9oy
         VpLM0boBJK/dhaHPxD7QOXZdN+YTSl7ETKYki+ma+fimnW4xMNqqhY7qnzpv0IcRP5i5
         j3Zw==
X-Forwarded-Encrypted: i=2; AJvYcCX4NeyUC8gAGJdl+KESOWu7gkpaBao6hMD50OgwgZT1xku8hpJNF/y3h79ftlo8IfWvBSmdAVm1bpJvCHI9Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8rFDmOZqXK4UqubupRD1DBt9u6g0iwEOAy3fWq8lOk2VKH0U
	NK80/yGkaiRrwlbUxZG8Owh41W2ltvGO7+x0ShnLcRQ/ei24xCfweJAAwnsdnCiyk2IKIo/bosU
	E6V/4oaoZE9SfiXnkIC7+fv4X2ySIqC5ffbfKg37Nlz0N6FOM1px0z9KSnixyvkZ+BPLwSjv+ky
	ZJG393HyikNvqiPsr4vk07Y7NLuKX3N4j6mof1InXhWEbukTgmiyFWRsAHLHVaIBQRL3YAoNlFd
	l/2uFFalE0LEx+Oo5rYig==
X-Gm-Gg: ATEYQzy3HQVS+mbazCTn6uScByGHx33twUC1w7FonaoGMm7znKXJ2C86WYSRqZucJ/o
	XZbkG+jxwx2zMFUWtYG0bk2Nnaj+FHbg9SC9BxOjsqEpu4hvJxhz3EPgLoQwXzZh8r7yOePU5jo
	A6bg7C2ktKL53/rRXxRVwHP+Q28IN0GfbQ+5DWibSYLef+0zo+i1Wf/bY2XSav/VlBAy97tdmNi
	3H4pykhSrFoNGN2XaAHR/BmAn7+h2zU+8PlWfyNvydUi2mqUJAzp8FLW5Bm2zij8S977toOuxCq
	yC3XHZK+iKcNhTD/slqnD3F8Q4sFoMC/9ih2ZFAC7g2sv3Qk4/BOKDpwoh2B45TMO+cY1tf9x+J
	yWYacUOZ4KB3sLL06ciHOJdOxb29VX4ejZPHdh/VC8OUNhGJtqDJT0XcJ4EMjHxtaOMtGGgA2J/
	VR2Je9Vmng4g2vz/0gy55WP8Qt8Nm2auOQei5sSsuQJliQ7Lt503SJFG34
X-Received: by 2002:a05:7301:1688:b0:2c0:bfe3:b95c with SMTP id 5a478bee46e88-2c109563bcbmr6217876eec.4.1774314545600;
        Mon, 23 Mar 2026 18:09:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2c10b296711sm985995eec.8.2026.03.23.18.09.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2026 18:09:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b97f04b44b9so74760266b.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 18:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774314543; cv=none;
        d=google.com; s=arc-20240605;
        b=hA7V8Jo0kn4651L6aiW8Z1PRsaF37YAnXwsGnZILiarZ2Vx9CWwboCY6Strx917qnR
         /0LQcH+kT3Tu9cLF/PYywVOZCZVFmpsL5isKrlQ3CenzjwnQ5ZW773ceLoPm733E/cSq
         Gixf0KQ/4N/qQb7N31VuFm36QQd/4MKaDEmgUkjnzv7qkCInzkfOgdaq0R/e1F3yp6sN
         R5VHRSC5WH7sjvH5OujLuUclS09Er+VEPd/TVshRD63FA2Xbkmec69PqtI2KJC0+V13R
         fuSfyeN+YTF1AWAx4c98isS2WjERWwjCRk8RRGgLpeNdhq8KyGIExgEiQsljH74Ftd4j
         A/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=10LYRv6BdbGuyL4E+Lq9YaOzMFLyGeYUTZxx5kY4YI8=;
        fh=csz0U7aLSdABcoOrtFyMt/tEEKDKhrquXjAZyT/yJy0=;
        b=ayHNGrNmhk3aNzg72DwSiE9jaFrTNGPNuRlJ4Ah4QvHIReacsJBPWDozNqtOrdEadj
         ItFTrP7q/NPZLjy0/QlBBNyb0G5RzkkXDaFbkt2477NYeehwEtJ9M5p+jJLKQ13yJUO+
         hTgupRpjUJa3M6453N7Acj2pX9W+m0qP7/WVKnKwMc0+6js1e+fGIkR8UO2UL1f8Cb0P
         wqaH/GVGcw0lad5ohwkVBFYkVfhi7LHKJE70NCVynP0vt52lENbk4tgq9ibCIu5FwnTI
         ufA51KZl6C67HD5MR3xJ1fCV2SjRI6Wv8Xj7BWlm1/LumZRII3qAs99P7zFEFxdwgpZO
         tRkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774314543; x=1774919343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10LYRv6BdbGuyL4E+Lq9YaOzMFLyGeYUTZxx5kY4YI8=;
        b=PkMRA3FQ0R/ZuXGofLmaU09CA+dliN74kvqKDmdrpK6XCHpVC2qH6yhuhcCAYTMLMV
         rzVmwRgAMCJITMEh6a7AWfo0QZMPqhHRez+I7MRLA6Z7wd7UmeXRkmnLXqA2u/0EkwGM
         I3IzuUof8ITjecTAzJ9OuSdaON4eHQzWyiI10=
X-Forwarded-Encrypted: i=1; AJvYcCW1DZMl0s2+80RwDG+QaCXgkugpGFTE9b4ZZQnEMY8ne5JksPooduZAgCrQrtD9cmBTqlNZQJ32botvbIk+oA==@vger.kernel.org
X-Received: by 2002:a17:907:6b0e:b0:b96:db93:5d0e with SMTP id a640c23a62f3a-b982f4e6533mr1073949066b.41.1774314543389;
        Mon, 23 Mar 2026 18:09:03 -0700 (PDT)
X-Received: by 2002:a17:907:6b0e:b0:b96:db93:5d0e with SMTP id
 a640c23a62f3a-b982f4e6533mr1073945666b.41.1774314542785; Mon, 23 Mar 2026
 18:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320012501.2033548-1-sdf@fomichev.me> <20260320012501.2033548-9-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-9-sdf@fomichev.me>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 23 Mar 2026 18:08:51 -0700
X-Gm-Features: AQROBzBKAHCpXL_0uNaZPLnOtADU_LCPjRl7n7D8OXK2y_iwcTGmn-vseoYacPQ
Message-ID: <CACKFLi=j7DO_d46jwZnmZ=OfmkoFA3AXUoX4nmF0tQuYt5Y3UQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 08/13] bnxt: use snapshot in bnxt_cfg_rx_mode
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, alexanderduyck@fb.com, 
	kernel-team@meta.com, johannes@sipsolutions.net, sd@queasysnail.net, 
	jianbol@nvidia.com, dtatulea@nvidia.com, mohsin.bashr@gmail.com, 
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com, 
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000018e215064dbacce4"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33749-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: D649D300546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000018e215064dbacce4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 6:25=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> With the introduction of ndo_set_rx_mode_async (as discussed in [0])
> we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to
> use uc/mc snapshots and move its call in bnxt_sp_task to the
> section that resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
> bnxt_set_rx_mode.
>
> 0: https://lore.kernel.org/netdev/CACKFLi=3D5vj8hPqEUKDd8RTw3au5G+zRgQEqj=
F+6NZnyoNm90KA@mail.gmail.com/
>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 225217b32e4b..12265bd7fda4 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -11039,7 +11039,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *b=
p)
>         return rc;
>  }
>
> -static int bnxt_cfg_rx_mode(struct bnxt *);
> +static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list *,
> +                           struct netdev_hw_addr_list *);
>  static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
>                                  const struct netdev_hw_addr_list *);
>
> @@ -11135,7 +11136,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool i=
rq_re_init)
>                 vnic->rx_mask |=3D mask;
>         }
>
> -       rc =3D bnxt_cfg_rx_mode(bp);
> +       rc =3D bnxt_cfg_rx_mode(bp, &bp->dev->uc, &bp->dev->mc);
>         if (rc)
>                 goto err_out;
>
> @@ -13610,11 +13611,12 @@ static void bnxt_set_rx_mode(struct net_device =
*dev,
>         if (mask !=3D vnic->rx_mask || uc_update || mc_update) {
>                 vnic->rx_mask =3D mask;
>
> -               bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
> +               bnxt_cfg_rx_mode(bp, uc, mc);
>         }
>  }
>
> -static int bnxt_cfg_rx_mode(struct bnxt *bp)
> +static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list =
*uc,
> +                           struct netdev_hw_addr_list *mc)
>  {
>         struct net_device *dev =3D bp->dev;
>         struct bnxt_vnic_info *vnic =3D &bp->vnic_info[BNXT_VNIC_DEFAULT]=
;
> @@ -13623,7 +13625,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
>         bool uc_update;
>
>         netif_addr_lock_bh(dev);
> -       uc_update =3D bnxt_uc_list_updated(bp, &dev->uc);
> +       uc_update =3D bnxt_uc_list_updated(bp, uc);

Will the uc list snapshot change between bnxt_set_rx_mode() and
bnxt_cfg_rx_mode() with the direct call now?  In the original deferred
update implementation, the uc list can change and that's why we check
in both functions.

--00000000000018e215064dbacce4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCR33Mw
/YA8D9hJe2rawnAotsSH69SPoOptXJYmGQDmvjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjQwMTA5MDNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAZK/hLs0Gm5EKim2KTMmzLSwFU9kz4BkvvzyAsOYD2
/+o8DpLIIx3C+1zyK4eo2/f0xcMbWL7tJ25Rg+uFfSmb2ZJ7T/QLj1uHSSIpW2k4X0OXIEpf71yc
G78A4ch9unqd9OTC5dP3L2fOy+DQu+WEckpdq3kehFtSdqMsSpTbpCMNPnPt64Csoz6jAyrNeQJ0
QboP8dBb10SexWfruwePEfwLCf3xCh72jB66zdgE7OhE8nurQafkPij1+YyoFqgLHXnrumW6SeY6
kDi3Tuwf+G4KTyR3Tq7RfyVaxpgIdqpeOZB/h3r4AIDvLv1wf7vD3tBf6mX5YpC8I96O79Re
--00000000000018e215064dbacce4--

