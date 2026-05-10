Return-Path: <linux-wireless+bounces-36180-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KjhCqMQAWqGQQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36180-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 01:11:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15473506C3E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 01:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB2D13001A61
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 23:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F8134AB1D;
	Sun, 10 May 2026 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJV89bor"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3EE2D97B9
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778454684; cv=pass; b=AZwJAQVWdvugMJGSo2s9pzg5LYhxXrOv69Rb0osezxTHzXWIt/huuxs0O+HOUS0c6/9xxcYx84FgBC0vo4h0UpW/0Tb32nlJe6XGpKMqwvog6M9PTkd3ztgGeI6Nry/56CEPY1ulX2fargvWlCVHl/mm6gDmxVes4MwcEQVtqdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778454684; c=relaxed/simple;
	bh=AcLAkU4nMkm5ti3PxMkTHQKSE4rDl1d7Aa7akkMioxE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VmLhHFlGkkB95cQjZFcQfZ/VdrUDrwyKdEGwUFaPEbdTRGkd10IqnBt/h3/dy4urLrAyqfiHgiPklulVbsWY0ryqvKtvRgbMF1wP4tjz9EcCvIT/oxF4Yy7rTU4l7j8kxZcm51XNJanCotlrESlvnuWPXuMk+8DEjD0AeBcEPOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJV89bor; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bd810cdc5dso38535467b3.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 16:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778454683; cv=none;
        d=google.com; s=arc-20240605;
        b=k9GDHHaqli8AOcm676DSpFI9xqU8P3ryXf2fzVi3b6UI7Zi3ORveyahF/rliJdZSAi
         budmhP+JCl6KcH4RcUi5u4LDH4Y8aglpKubq9gT22o8WgVjLmV2hIc5dF16wh8DOauLA
         l7rwr9M1vBT4nrS/Xfr/ULi5RE2WzN2R7QdYM2FZOcz1UosCUGbSJfDc6zRi8z7DuXPW
         Vc7IgVfW91glf8UDC2wr/7f2UopidgE61ifc1qluvtP4mF/OD3xUGR8vsMr+yoEiubCn
         akBCB0Xt7mjSGBCW4B3xHdD4DmTWYs54ghXFP9FcjYbm69t6GIJz6qa+Vb+OrWD8xm6H
         8GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AcLAkU4nMkm5ti3PxMkTHQKSE4rDl1d7Aa7akkMioxE=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=aYGfRA1Bu3PEmUArohXHlj6qhJbZY8QMWIgGvQSuzoRbr0UtwlWvtphEa2tr79RPtY
         LXV4MoDWIS1fH9gay08iec8Bng3DOV/9IrbcpbuhURANAZFHa/i5Dlzl5kklSSng0vrL
         csbSEHnBFrcg0vTFE751FITZVfEMygRFuo9o8/oheYSQL9Ik5gSS5CSLdwW2EFU0tfKQ
         FXxFptVPWzUrk4knaqVnqOk4WSApdbQVX/a6gPlJWSgSkA+wgklQSe3zKwBTz5dbnWQ/
         wE6JQkITpk0RS5HPC21IYlExYu7My9SnbitluZrcytfL4cv8U+6PlU+9CYgtztBIA3Mt
         2f2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778454683; x=1779059483; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AcLAkU4nMkm5ti3PxMkTHQKSE4rDl1d7Aa7akkMioxE=;
        b=VJV89borq82j3eYMPIjJt4V8SZLckE4/IndKHnk8MrHDIiaUMCKrjfNoxsrboMGq+p
         dskjuAmEkJsNWJHucT8EoGA1ry2K1mAR3LLYbotmM27XG/G1ukAiD8ydlwiWElGWKHeo
         QNA2/eoWKILd0hO5pulgwB1BtSUsIuRl/uu3dXg0PBj5kx7FpyAesFOMkAtqBS+oNF+j
         9au1MCp7qit8QHoOzkXizWkORYdEvkySQsUGPjUThVclDKKqthmZKC/VngpeijCW44eF
         qXdfwPWe/iopscopBSzRyh5PYS93AP+fAyiFZc97fxMoCgo/gT+BbTNzA/r279UkIPv3
         +euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778454683; x=1779059483;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcLAkU4nMkm5ti3PxMkTHQKSE4rDl1d7Aa7akkMioxE=;
        b=nTsvw2ZLSWHA9fgcYlycI3FipTOgLkkSmufLsCBjiSPnVWIS/zl5r5Oaw3BzCIjUsX
         U2FbsIXtaOXITj1MD5NFNbGNHEktmmCUMzitQtGzYHTgWpG6trSIHTE05Z854p4f+9GE
         ct5fP9agsjbjJrWe5ZA8NVh6XGOGa8fTjyFeiOO+o1i5PkRbSCgXDIjzf5Xu/I6HbnRi
         Rjyjz+AxnLD7u1DBU+L+IoY7cyxjWhpJoBn+h8k7u4x1a0PeN+gML3wWhjDJEHQDjMyM
         hloSc1DNC6fTZPPMq16X+BDs29Y8GLD4lRUMu8Dj2bbnJwUYt1nweTQxyeo5GEaje9yE
         lqaQ==
X-Gm-Message-State: AOJu0YzEhUrde6F3Lk1fkh44kF6vapRzLhoG8fPiX+tc0u2UyqHjjmxu
	Lm5kolcobSJIlXOv58nPwULetFpOwcMLp5GCm/NOiZJg2eDyeZnOKRGAAayldMdRkV/vwJ7coZa
	nJqXHNw1zYe5sFPQ4ytCwAnr/M7b3shAHGEHejmYCpg==
X-Gm-Gg: Acq92OEZkQNlwvUvZXnoaZeUvx+UGFONuDDQ1yFLZslPKPYygdbEdc6thrimUaqMi73
	6Zv8oQBU2s01t2NZkkGLxKsQtlkMhJkJNm4q4z6glWvi446OqVAb/1GJwKmCwD8hPcErKawgbSc
	c7zLQ1bszk7xlh99NyI8qSbmkeXk1AVqvZ41g/vUYdi1eyiluyCAjhc0Q2KHgegeqYZzmQYDhLv
	15x12mHw3OKnsYI8z3T5gCdINjopp7h/ZU6t6iupeQ79jaGd7XPSZc32HuYRQh5g+/LrLp9ZTj0
	D1uNO0s=
X-Received: by 2002:a05:690c:398:b0:7bd:5c5b:a4c2 with SMTP id
 00721157ae682-7bdf5e7cabdmr239007257b3.23.1778454682624; Sun, 10 May 2026
 16:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Isaev Ruslan <legale.legale@gmail.com>
Date: Mon, 11 May 2026 02:11:11 +0300
X-Gm-Features: AVHnY4IF1Y0VBR6B3lzs7-LLo6sH_cbEPliXsrWrN83qYVObVz06wI7vKWiRQQM
Message-ID: <CACDmYyfn_EVs483PB_032-oCDf=DrL1gdFx2QjN6djz=A09nbA@mail.gmail.com>
Subject: linux-wireless+subscribe@vger.kernel.org
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 15473506C3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	HFILTER_URL_ONLY(1.20)[0.54545454545455];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36180-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legalelegale@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

linux-wireless+subscribe@vger.kernel.org

