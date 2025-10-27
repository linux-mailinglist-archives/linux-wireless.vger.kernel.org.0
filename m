Return-Path: <linux-wireless+bounces-28322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E92EC0FD84
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 19:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAFD467867
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F28031283D;
	Mon, 27 Oct 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0f12F+W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84AE30AAC8
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588202; cv=none; b=UtIr+X2UpKM24o3a2M6qlRklFyNki3fMk1HlY50WT2OwwrjWp2ja4h5On/FgjalvVF5yrKwqS0wph50pC2wTgRD5fO/0N20X1aGmxfUWbSOnKXbDrqb/vhUgGil4RP0JLXVcHiVcUITOZ18kRFm3VlichoVoAr879kkYd2HEmds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588202; c=relaxed/simple;
	bh=z83AXuvcweGfzJ1YzykNAVHCd4v5jqaWPkQKxlN5fdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJ1vbxpU/1FgDG79KTUA3mmbRvfSeWs6wr5pEg5kfwPFbPITlaPgmO9vEQY77hiQ/sPHlYtg7+TWz67MtQjiykCtPDKleNcOZ78I9fh9ZrtxKIh9E90PkQ/w7wZGHM8Y2UHUlsRnJxpbqnR5J/KGeKdoxkHFUe4+KW4c6QXIksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0f12F+W; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-781421f5be6so55486177b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588200; x=1762193000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z83AXuvcweGfzJ1YzykNAVHCd4v5jqaWPkQKxlN5fdk=;
        b=c0f12F+WW0vGS4nnwmN0CAqpGqsYPbcNoXMYqtY6tayUXPn+w9w1Z7+TvQ9TJHMIaZ
         e/oLYIc2o3HBdvrDLSTORpq2S9NYZfE0n0raZs89Cvetx52IY92qjlb8LIZo8QREKQcp
         w8Z7WB3QQ32NfMfYYINjaNqA9RMW59deUJGNEiqIdr+wI+BTsPanrMhYvO5bAbkw3fDD
         uYkIN0Hn10UwhwKzoE5X3XKW3eFwkk5w2j/OkdlaGEqEMq8kPOBmCSAk8Xlfmo4D5BZp
         SsatJCpkubkrNhEa8qlNH+LcKovXN5wnD7DCF1DvWWnvT9+XwBAVynn5xuClkcmzS24m
         pMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588200; x=1762193000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z83AXuvcweGfzJ1YzykNAVHCd4v5jqaWPkQKxlN5fdk=;
        b=q29cyWGdJGgE7lriarbNdinXXY59tvbUGgUmrQ0ymNqwml4PekgDmLLpM2WWxpcnA5
         CULAZpPAW20paLhRjJ1GBHMXVsw6t7JldMHpaYu0eUa/bo1QSvD3TTFGPYD6Z6J+fSB4
         kFy6iRf4kMRcCl+u8xsRKYD98LqqUbYFke3wJjRjGEJ4+5h9WFeDjLB/v68GyPhtwXEv
         /YPcMR52iw3n1GsX09X+laLcvafn2TaAlPzao1OkFcreBGN0AqqAie63snSWk4CIPgdC
         UsKpbV8S+JX3i3lhY1/IDqLHEBRdfRP6svQ3IfHTZtNcK7tPFR7c50+F9Tvwb2LN3sp/
         6Ygw==
X-Gm-Message-State: AOJu0YyNM4ia6wlSyGqpNIMMVwhlHpAK/oVx/lI6oFhr1f5Ny8LtULlS
	aDDm5fBFElB9nZ31kWD/gEPBya2fqhWF+Y8K732pUk95mOPDuWnmXoeRs+mpU7gJz66V2g8J2tE
	84wk+4R4OxBZur67dOx+O1E0AN9goQX+9Zw==
X-Gm-Gg: ASbGncu2Cc42bdpVGeWTpsFaIEoSBZJbf43nQcmsj6QDdTZf/fvVN6LNn4fDUvmKaR+
	NQftLQn4LB6Gi5BQlL6YMwaejul39xB9uqTTZwwlbTYi0zsaMToGxG24r1pGKmsLC677FE/kCrP
	uAMfj1H5vFgHApHFkQLxjdb1R9U4ss5jQca80nNwPx6E/tav8npE4o0eNNK9kWVIYWy2cWrJxr8
	p1RFxmHZweu84oJbY47GOOlQAwkbuBECLvptw0wUA2JzUXfkvEtx8H8PUlEhibVRkV96HwAwYiN
	q1YHNSax
X-Google-Smtp-Source: AGHT+IHEjGHWDboqhwqSgR5zzYygFRWXIgKKmRw5b5ajo6pajcH8E9/Do3d86XVr5QyKBXnYP/5zxJVt23CEn2AWdc8=
X-Received: by 2002:a05:690c:74c2:b0:784:8b01:c21e with SMTP id
 00721157ae682-78617f34811mr7129517b3.45.1761588199733; Mon, 27 Oct 2025
 11:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024203046.42275-1-rosenp@gmail.com> <b725672aab8c5a006603110b46e6e15495acccbc.camel@sipsolutions.net>
In-Reply-To: <b725672aab8c5a006603110b46e6e15495acccbc.camel@sipsolutions.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 27 Oct 2025 11:03:08 -0700
X-Gm-Features: AWmQ_bkES62pMCkmUYcvxmud3HMsqvB9OnJHmQIGlhxldOaEtBshd7JdM20rGJI
Message-ID: <CAKxU2N_zzZX7RWMWqRfa8PwiDC=gZtqOZkSPWdcUKrd9eLSrVg@mail.gmail.com>
Subject: Re: [PATCH] wifi: rt2x00: add nvmem eeprom support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:13=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> Please always tag patches with the tree they should apply to (e.g.
> '[PATCH wireless-next]') and make sure they actually _do_ apply.
That's embarrassing. Will resend with both issues fixed.
>
> johannes

