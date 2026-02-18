Return-Path: <linux-wireless+bounces-31987-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHf5NwgzlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31987-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:45:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4813115A5F1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D41FA300C591
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57F82F39AB;
	Wed, 18 Feb 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWq3uxCe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7EE2F260C
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450956; cv=pass; b=jVcfsyRQOWV8hLy8dDL+BCkeo7t5VaeoxzdTIfFoUP5wJWlRVTEKSvUAu4hnHwBGFg2HleaoGUytoisGT7Ell+BxSY4ugjB0/UGNvSTUkWq9DbifDRPqOBPMvrHDlgDo2hBpA8NDN5Y2FcdLG5BF7Ej6mWwMQWj9+qkNHeYlQOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450956; c=relaxed/simple;
	bh=Kut9itH4KGS+1jezuu1kMPaauhlTNVrL1GqgQMwPuCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLuGB43/y0I/wqZqbPYEcc91zlUCecYok4lUqDdr8WWGSbsamBFLGkEQTaSDzzDzF3DNo7dhL5YyG3N++TyVWg621eUw5Be+NaGtPA/CzBi653gLTgo5XHuG+GQmXcBjPQ8UdzvOp6rb6OG4KKxiXYSN7ObD2Qjro7thm1d/+p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWq3uxCe; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8947e6ffd30so3278136d6.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 13:42:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771450953; cv=none;
        d=google.com; s=arc-20240605;
        b=giAFtyaINeHSUlP8hH+xkEydPeJuBrvESQWyXi24+iPPTxywSla7O+mm5huso0DY+r
         5uZyg00Z9Y1Kx41DquN0/y5jPsc7BAOqwDCtCtPlWDF7tpGXqcaf9I6ZVwPHrUJs9Zgj
         Cx2edXpugfOBch7+Org8GmDOBcFRI3JJ3+vUq4luXY8l7VLGMDMatngZD1q1613lH6H8
         hW4XJFOTv2F8MCudrIaLzigaN08LeWiWdxHK3F7n8r5UhF8a9AwE1//8VJcycUF7cHax
         PQipTiptPav2HR84Htx1REjaxkGqOPi+eDMK3nc4FlxZylvtlwOPs2KSHYDRmNYFund3
         wmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fdl0A8UixsIff/MQ5v+B5jVRqHb5yulzDbRj1E6u3Cs=;
        fh=TR1GMqIHatZBohzgq7IqfPaDZdgfoEqYLmTN5aa2Ejw=;
        b=SunRVCIKJN4EHLPifpEDjH6ggKD8hR9wrHvbWDatglO6LogI4AnTxyBfT/NguvfQ1N
         ZgVvcnCGhekzCk3m4hE9f4YyUHHl+6dCIPSBtZEXb5Yg0rhCueBo+FwtZZwsEZpnyS1F
         NVnQlSc/wS8bTmFGwSHbmdaHhKCnrf941KwE+DjSzVjhjy1GPDe4IsjMYsAMdRDbYMAp
         34WUF3TYh2aIF0pzzzszo8kQfNKn16n+Gsp4w1F+dNxowPCyqxEcq+ShWX9N7wGQDQLR
         l8VgfnPA4Ioro6r9gXE65H37M9eUa55jfKZ1oXdx8kgJYV4lyC3dJAr4iFgv9E4ud30H
         V6Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771450953; x=1772055753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdl0A8UixsIff/MQ5v+B5jVRqHb5yulzDbRj1E6u3Cs=;
        b=cWq3uxCeBP9EK2ynO2MhTibZAvHgXAbDCJ8BbKl2BiPdoTj6B+pUSGxpaqwltdSmx+
         Al97xgil93Qi2LGQDWzEvIYCtZ7QpARlbap4ofdKmPaL9FcdUehcLcHCoNGFTKIjcLne
         3x3F3I3j6yo8e2d6HASYqKHfJYSXnoQhpFOpH585+Ijz3Tqn11Lf4ObZhqcwusBHpfDq
         gMluBg9wh7NB00sn184MYLNH8hn69tETFM45HEgr6/dv3oPCbZAEyf68lPF6OsKtDJn4
         o4L/2/8cM9aBXYjvbyoz2OjVFK1LhS9GKShH1uW74B6iH71BXuLmYJkLChdDxcXmIdKc
         2juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771450953; x=1772055753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdl0A8UixsIff/MQ5v+B5jVRqHb5yulzDbRj1E6u3Cs=;
        b=iOVEefX4Jwhgrj60cIfnu62mGZyzihGGGZWbLUhqICZ1gZO4SAV9MEBl1qUNW08OWG
         mhMtqP17fJei+U3PvRe4BidaN0X7aPsXjN6S4KlOg1ofe3cr9dZ7kJY0cJPvCV8vkTxY
         zRcqsV/1JxG5YLHjWALJX6CiOhTxdvgB3DtGkTz1/xIJYJE8loqspdeTaOq2UgH9qDDe
         HDEdJsrtbgX4sCeiz6Sm4wfs/0jBfNgBnsCauXxwOQXOVI1zi57yIuqmHYAUDJ6umRVh
         5H1wKQoUjiIRcjsq3RGQd1jtqtBFk1+Yv8TC1GwM4jcK28xpfUYbZU7mqD/mhPx2xFVz
         dEpg==
X-Forwarded-Encrypted: i=1; AJvYcCVk+0pf8gBR02mS+KWcREzIBb/mwIZ9ASt2Htwg0cF43bYv6mRNhEVqvIHQpqrlRa7Kk4n09cYpW0wyI59MKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYi+14J5MIs+LLJshUTWfwRfQabESNJCBQep+Vk0nHGfeoBTZs
	PRoaz7qwSNoQLntUvFeBPlwYlCUjEEowlePdyzp0qFC/wknuHFTuYuhs2798EGgiwBa951/fyRK
	Q+Duq564kBE/Cq8FQ4mXvWo7HRb/WOJE=
X-Gm-Gg: AZuq6aJY/2j4T5mEeQv0LRZ96cBUoCz7XiPXcEQ70hn5KsNlyfSTq7BIuNCbcR9LKLo
	a59Xo8UmKnqGFSo5eiBpVSzYjbOBoWmINo2vuroAJ/Pb/fClpZLs/QsWnwYw5UySvgGsgmVdc8h
	nNCOLHMvLXaKEAhomAFHyM6lcYXnzQpe4VUcM+jiQNZm7wa7Vm6LeoxbgOYFUEtA4E1MpS0/wit
	CBHZWntvD1PTYtm5rhHZo06814KelgjPDsDrGTLtT9C1ZUujQ6aS4pKc05uR1aqm/BucOtwu8gh
	Mn1ihSjTVOFtb2aFJTW01/uZW7D/41/2bM1cvoOSRMYMC7J7fuR0YTvvxuJdV6NDawvgp1nRYgn
	hQKxR+eoYpdZSBogIHjB4PYddity3LEuMBu9oAtvM3XKJrO/aZxC8viItGYf9KMruLj0F83XE8m
	Qx5UNHTedkorXFvsj4oAEizw==
X-Received: by 2002:a05:6214:202b:b0:897:306d:98b9 with SMTP id
 6a1803df08f44-897402d74ddmr259168586d6.11.1771450953049; Wed, 18 Feb 2026
 13:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218213501.136844-1-ebiggers@kernel.org> <20260218213501.136844-12-ebiggers@kernel.org>
In-Reply-To: <20260218213501.136844-12-ebiggers@kernel.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 18 Feb 2026 15:42:22 -0600
X-Gm-Features: AaiRm51OR0UA1EoYTzTIBq9EZMqc4hCYgiV_-Pm5bfpkALLXMax-4eNCD0kf6YQ
Message-ID: <CAH2r5msdQw2KLyMJMoSrzFoGoJfmuCsBj_qeT34sH5b+6DLWFQ@mail.gmail.com>
Subject: Re: [PATCH 11/15] smb: client: Drop 'allocate_crypto' arg from smb*_calc_signature()
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31987-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4813115A5F1
X-Rspamd-Action: no action

Acked-by: Steve French <stfrench@microsoft.com>

On Wed, Feb 18, 2026 at 3:38=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Since the crypto library API is now being used instead of crypto_shash,
> all structs for MAC computation are now just fixed-size structs
> allocated on the stack; no dynamic allocations are ever required.
> Besides being much more efficient, this also means that the
> 'allocate_crypto' argument to smb2_calc_signature() and
> smb3_calc_signature() is no longer used.  Remove this unused argument.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/smb/client/smb2transport.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.=
c
> index 0176185a1efc..41009039b4cb 100644
> --- a/fs/smb/client/smb2transport.c
> +++ b/fs/smb/client/smb2transport.c
> @@ -202,12 +202,11 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, =
__u64 ses_id, __u32  tid)
>
>         return tcon;
>  }
>
>  static int
> -smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serve=
r,
> -                   bool allocate_crypto)
> +smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serve=
r)
>  {
>         int rc;
>         unsigned char smb2_signature[SMB2_HMACSHA256_SIZE];
>         struct kvec *iov =3D rqst->rq_iov;
>         struct smb2_hdr *shdr =3D (struct smb2_hdr *)iov[0].iov_base;
> @@ -438,12 +437,11 @@ generate_smb311signingkey(struct cifs_ses *ses,
>
>         return generate_smb3signingkey(ses, server, &triplet);
>  }
>
>  static int
> -smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serve=
r,
> -                   bool allocate_crypto)
> +smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serve=
r)
>  {
>         int rc;
>         unsigned char smb3_signature[SMB2_CMACAES_SIZE];
>         struct kvec *iov =3D rqst->rq_iov;
>         struct smb2_hdr *shdr =3D (struct smb2_hdr *)iov[0].iov_base;
> @@ -451,11 +449,11 @@ smb3_calc_signature(struct smb_rqst *rqst, struct T=
CP_Server_Info *server,
>         struct aes_cmac_ctx cmac_ctx;
>         struct smb_rqst drqst;
>         u8 key[SMB3_SIGN_KEY_SIZE];
>
>         if (server->vals->protocol_id <=3D SMB21_PROT_ID)
> -               return smb2_calc_signature(rqst, server, allocate_crypto)=
;
> +               return smb2_calc_signature(rqst, server);
>
>         rc =3D smb3_get_sign_key(le64_to_cpu(shdr->SessionId), server, ke=
y);
>         if (unlikely(rc)) {
>                 cifs_server_dbg(FYI, "%s: Could not get signing key\n", _=
_func__);
>                 return rc;
> @@ -522,11 +520,11 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Se=
rver_Info *server)
>         if (!is_binding && !server->session_estab) {
>                 strscpy(shdr->Signature, "BSRSPYL");
>                 return 0;
>         }
>
> -       return smb3_calc_signature(rqst, server, false);
> +       return smb3_calc_signature(rqst, server);
>  }
>
>  int
>  smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *ser=
ver)
>  {
> @@ -558,11 +556,11 @@ smb2_verify_signature(struct smb_rqst *rqst, struct=
 TCP_Server_Info *server)
>          */
>         memcpy(server_response_sig, shdr->Signature, SMB2_SIGNATURE_SIZE)=
;
>
>         memset(shdr->Signature, 0, SMB2_SIGNATURE_SIZE);
>
> -       rc =3D smb3_calc_signature(rqst, server, true);
> +       rc =3D smb3_calc_signature(rqst, server);
>
>         if (rc)
>                 return rc;
>
>         if (crypto_memneq(server_response_sig, shdr->Signature,
> --
> 2.53.0
>
>


--=20
Thanks,

Steve

