Return-Path: <linux-wireless+bounces-27444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C448B80F24
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9140C1C83032
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63CF34BA5E;
	Wed, 17 Sep 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1M9yvuV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632B34BA5A
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125879; cv=none; b=Kv2dT3sAUrcr7+IotxD+AJpOeIH5RzrRebHHn8W6+gT44BvTl+3YvCyMZeA/vp7MAZgBuMXGllhCwvuTvbplrpq4NZj5Q9fDRPFPnRiSOKU/BJF5oAQ1M7aAADNUqUwtrwBx4OISziDo0U8PBJtnV6Ks9dOrbAEpA9TQSJk0dbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125879; c=relaxed/simple;
	bh=t9NBOLHxyYWUxTCJ67GeHZh+kdZ522EcevTTLoASKRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZkf4iiKKuqWMHN9LqwbdH4HzELzt4n+Y4raQBIofr6/AOr9jSpmowW3TTKsZsCHz/pTdSlMYGeJ6KSOREyvXJh9onSQV0xJ8QgZav2tuT7CHl8cGuYd6CRc8npYA6BKsPIBWjeAyahPoSk97gudK2SwCLeqlykHZG58YGN4rRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1M9yvuV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32e2794c97eso3135211a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758125877; x=1758730677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t9NBOLHxyYWUxTCJ67GeHZh+kdZ522EcevTTLoASKRI=;
        b=F1M9yvuVisD/pmrYT43tJZ7r/o1eAEjiN6oQkpNb/z8ouJmlm7rLE3/sDkcDbR+t9A
         APMkaMisxRsYDS6fhTCDd+wae/XtIkQgqq7UkMfl/EgsjaccuQZYRI4bgWavSWh+rNEb
         JP0NN5pCukmSJvo+3xSPg+YNkVKAQNsaYQ8RT/7dqDewmQ0akjkr9Nbmwyumbt3evA4j
         WfEi+66PQNzG/gTAznUv7FsJSQtIEbzkSNQ8C8kZVpkHeSEI/2e+tgmhpgC6MAH/AeMc
         hRTin2Kf3Z2qdvDmHojKrBfQfQDWlNEBGJT7DoxkPqH9AjWiAMrwI4xbOoogCYBuaZIO
         S+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125877; x=1758730677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9NBOLHxyYWUxTCJ67GeHZh+kdZ522EcevTTLoASKRI=;
        b=pJ6+rD00v4p98CK0aiNBkzzCz157Go+000x9D4cDqYoYIVnB9XQYT/MyMgyCA/fGYb
         vKzqjZhy7V2JUYI9MumoG8W3McAOfPn7a2p7fp30gXXz2LzuiHV/flqQH6bQji0cU3wO
         kRkNYEtICZPi1E8ARR5suGNZKisopRTIMn7B/jcpS5mh9XElk/0mFZ1O3pnXl90tSCwW
         HbLUcokr3Qwrfb5v186sLXNuAFot8ik0i6rrYDZJb7Hu4hR+Dw/Z57iXyloAMVxVLE13
         I9/lkB8b5mbA1XfFG5Ab3FPjcjHYfYDTAlysUttjFk69QSO+e52GfBPYrlaA1UxV2XbI
         vVaw==
X-Forwarded-Encrypted: i=1; AJvYcCUyCs+xJBWJUTQz0sSNcWFDbVdDMWQRNzmNjqU3mVvulqnqDMD7h91RxKllE9zkIPaEReolzk629F2Ct2FzUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPO3II4d3R+pJ3zC9lbUDnqE4a3M1zKD1Uqaj2apjyOC2i6n8i
	vFTjFUa7pUiA4vQc5BeDb5fQX1WpuI+Gg4Gz6kRdHCZFLGSf52tTkgpjiGPJ19EdM4hw2EBfbzK
	2/VGPSDxOK0n5S1T7vzNi8+1/MY0WEA==
X-Gm-Gg: ASbGncuGrJOU4tCYGPBvoVutaFYE3Jq8znIObOx29l3LcFEv4ENev4jNgH9JkL0hmP6
	IpyVja8mD3OQSD7Mmz3/++e87IHH0tgYkS62l1l50b2cOA2J70y9SHqFd0jIQ581jIMUUrBq2kJ
	Uzs9IcacG81Jj2BxNYidKW66NM3h4IRhWRWmdySoQY1Yqom2JnIcwMsPRf8ZLz1bMEU54/yLukQ
	rfCx7mdUTV1Vt6vyw4BqtBU
X-Google-Smtp-Source: AGHT+IHhWVMCTt4FqMqxsaSGtlsIXs228pgZwWTuHQW/DpH6t9agezpr14wLKdatbZd+xu+bC1vNCkjiD3OQGJe7Us4=
X-Received: by 2002:a17:90b:4c12:b0:32e:2059:ee88 with SMTP id
 98e67ed59e1d1-32ee3eb5a2amr3782547a91.6.1758125877216; Wed, 17 Sep 2025
 09:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801202359.794035-1-frut3k7@gmail.com> <20241009065051.51143-1-frut3k7@gmail.com>
 <b58b5b2e-bf9f-480c-810b-2cef29aab82c@quicinc.com> <CAKEyCaDUfn4jtCdTt9JJ-Qe+CCudORPwcjj5i5=G28ANc+eCRg@mail.gmail.com>
 <87ed4dr5pj.fsf@kernel.org> <CAKEyCaD-1GO1NL-=1E92BE9=XKa2PymOAY14vMmtwYGLsPjeUg@mail.gmail.com>
In-Reply-To: <CAKEyCaD-1GO1NL-=1E92BE9=XKa2PymOAY14vMmtwYGLsPjeUg@mail.gmail.com>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Wed, 17 Sep 2025 18:17:44 +0200
X-Gm-Features: AS18NWB9R7Ie_lKbBliZB9szhNdDYZ285LPdqC-P9iVC3crG-nKLXWUxCy_BQt0
Message-ID: <CAKEyCaAaJGUX56Xp57KWkouCgpOyPNTqysRZyGtfsyoJ+ERMpA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath10k: add channel 177 for 5 GHz band
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The changes are added in the ath10k-ct driver:
https://github.com/greearb/ath10k-ct/commit/8f2254b8e0554e78efcef5fb752be0eb3573d281
Is there a chance they will be accepted here as well?

