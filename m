Return-Path: <linux-wireless+bounces-24893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89601AFBF77
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 02:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CEB3AAB4A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 00:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23001C5486;
	Tue,  8 Jul 2025 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juMtM9il"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F0624B29
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935873; cv=none; b=C31hGJ7ZHpn3dGz2AVywqrDAr9nWkQmS0Ljk/tyvI2l1rNnJQEKWrpjoHMGvENKVPNHEG1SL+lzu5D+gwAT2cG9fHpcGNV8+Bl92djwkGlX2dMTnaQB/tT83IHp4H9khyXWz8cLRAFNXLO8jYhWPsXEIjGnJQminyu5f5q0v9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935873; c=relaxed/simple;
	bh=DQQ5Y56mkC/VnzMh7cG6WlsLXOhXQ39Xs2xGyn/XrcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii8xpRc7QC6LaFYG4Kw2Xyvq/WFIL/07zlBC+j76U6UWF+kqS9CMtabW279fwqsAc6hMJ3yVMdVbFc90IyRMCdQXv72neCV+vhwlUGngmH94Rwy/nj7YmPgJCVLjB4wysNxu9+mNenvPLyESJpGC7u3+jpualTuZjzLfU6nX110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juMtM9il; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so650620166b.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 17:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935870; x=1752540670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQQ5Y56mkC/VnzMh7cG6WlsLXOhXQ39Xs2xGyn/XrcU=;
        b=juMtM9ilRe0jphiOvR/I792iGSwePrR940QTkP+wmoC9S2iI/w+Cw34cuq4f/1dG01
         wxW5CxLZgYHWvsXpGufGkFM2/tr7XBQc96dXM3N3csP8b+U5EsU4V8V0CkSTCub8X+AD
         T2299vMJwVzx77R06rLyb2YNFsEs8XhPonDTn4v5jTpVRNBqHJm4zGu89DRePpimdv+j
         tnmFbUGEeGGwZ1NA0dars5NnQeTAI5diNGXmZfIUIs4/OP5QPxCe1LYUtu2r+PBVV8wv
         +xWQNiTPSmcn7Yh6jNwLOaOVwCQw+yJ7pC5nv8sslG32diImJU9GUraYn4j5PSPyFmgQ
         lPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935870; x=1752540670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQQ5Y56mkC/VnzMh7cG6WlsLXOhXQ39Xs2xGyn/XrcU=;
        b=YXbC2pul9vX5xakaTWI2PE8EonssWCyrmX0QjK8kxyTkiBuOO8j6h76tcBPu4YtZTM
         2yOkQpRdvmJId9cMzCig/j9iE7TyY5elUMb4pdRJbIdentvO4sZGPH/ip4gDo+lhlu6/
         +GKp2OPQi/CxNiFb/Idnmz/E/9fuu6r30c/B/b4UNkgU6ZZDJ5Y/u3ITUd4IFG8iWHOW
         ZNmomuAmZepsP3entc5QWzUjujOtDFPRB6Zr4DAzsjbF17HXNp84gDKmCzO3BaEctfZt
         q2Kanb6uLc25X0Kk6owI8v1E58ETqZYGh+197YBz4kYDxujHpzEe5pb5aRWFNCXXB3Gy
         jz+g==
X-Forwarded-Encrypted: i=1; AJvYcCUi1NXb7vdS5XDe09CFW2qxqNR6eOqzMpIE1Njpo3QXgbdaqVDqLJSTUSC7HpoK8jM5cWXwY/WsyKo+nwKOXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBObkob6GDHAD4mevqbFBxcgdb6ywHbjtXPH9vHelpiSrLYhy
	/dDlBR9COBAcmBytU1omY4lRXfTA/PSe29IjgFP6R1y56SXkpfAmYTAMl079J5n5tD3bS279T2q
	7lEpZ8R8wvCjT5n4h4/tk7+bYlDqCAWk=
X-Gm-Gg: ASbGncsNhY/oRc9lZE1x/jyohEt0zdmiokf5T2QP6RI8PE7Dgaoc9pLp00gBtZZJQ69
	0ERqZM3bTBnFhZL/H5bWGLHJh5D8y6Cz+l+KSzZAY6rIwOCJL+70exQRt4HnDlA7JBdowFYR2Ic
	g1Z//ln/YmwzjCiwUGTzyjR9ajBwF9MfWrODco6YNq+2fZnDof+n6t8Q==
X-Google-Smtp-Source: AGHT+IFeq0e8gWQhXOEChXHy0uoRczTpCrBBKoBBnVnO0unYx4AjSMYNBJ9mzQYrTcKgYFZc4venqdMxYnJMnGotDLU=
X-Received: by 2002:a17:906:d54c:b0:add:fb01:c64a with SMTP id
 a640c23a62f3a-ae3fe7f113bmr1374126666b.43.1751935869861; Mon, 07 Jul 2025
 17:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707024615.38507-1-pkshih@gmail.com> <20250707024615.38507-2-pkshih@gmail.com>
 <1B25D881-49C4-4805-9EF8-76E3A9D9A64C@nic.in> <CAGb2v64ZKoUzQoihvPZMu4e7a+8=BxYBX_U4ZfMW_qvZhx1ZfA@mail.gmail.com>
In-Reply-To: <CAGb2v64ZKoUzQoihvPZMu4e7a+8=BxYBX_U4ZfMW_qvZhx1ZfA@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Tue, 8 Jul 2025 08:51:26 +0800
X-Gm-Features: Ac12FXxiz7Nton_TJk1lYYQCOcI3V1W_qxj9ftUyTU_kYIXWz5hNaJSWifUO1Xw
Message-ID: <CAHrRpum3D_Wxik8rpZBhosj4B_W_ocBBnC7Hms36tF7mJ_SkyA@mail.gmail.com>
Subject: Re: [PATCH 2/3] wireless-regdb: update regulatory rules for India
 (IN) on 6 GHz for 2025
To: wens@kernel.org
Cc: Gaurav Kansal <gaurav.kansal@nic.in>, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> I see.
>
> I will drop this for now then, unless Ping-Ke has any more information
> on this?
>

What I can find is a consultation [1] on May this year. It needs some
time to have decision then.

Please drop this.

[1] https://www.trai.gov.in/sites/default/files/2025-05/CP_28052025.pdf

