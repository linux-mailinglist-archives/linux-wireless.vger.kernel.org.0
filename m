Return-Path: <linux-wireless+bounces-14234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5789A4F19
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2024 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142D22865D2
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD32207A;
	Sat, 19 Oct 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYkm51N2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE98472;
	Sat, 19 Oct 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729351944; cv=none; b=rEU54tV++pfk4AIKw3YEWBKbr5YtjMy+wnzh6D97onG/AyO3TG9lku5BkzFqY6jwtcnjhXRxHHcPxZoA6n1W1c1OqxrDJcsNQpgPdAawVtwS/H9jO61y7aEgHG3O5BpevyFuN4af4/Mj1O12SDhDN5ZOWZPTKIJRxp8HK7+aEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729351944; c=relaxed/simple;
	bh=tMbXRc4YDc45MT1d2qKMPKKlX3fx86b90pw720KiDfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUGSnK5+pau/TjjUYf0TwJr0O5s6VWj8pk96Wk9ixm6VmuPg2Ti9xsDpaiWDAe7jPOOypTuvOeFHUJNRxVXemWv0LO2ubEQnWxpOGph+y0TzSS80I+MD0Sdk7ukLAkeRfwIp2Xpcm488lBf3djQ+aOw8T0dIWS8bcMS2hTlL30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYkm51N2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e681bc315so2042233b3a.0;
        Sat, 19 Oct 2024 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729351942; x=1729956742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMbXRc4YDc45MT1d2qKMPKKlX3fx86b90pw720KiDfI=;
        b=JYkm51N23CZq+6QS9vEVq92VR/egxaVNxF0xb/qtGiyTuDkmt1YLcqVGHyKb5AAzok
         PSEuNwcKT6+oTvoEecV56nK4DI1pqDf8iVDxPz+voNq0XDSwmfjb9rXFr5oSLjnime2y
         QVw4hhKnSiYBVT9YwYjNE1vttUzc76Jl8WPFRYqBVzKkK7wdGiqewe7Zvwzwu+jl1r6O
         oyjqQ/KgZR5scQooDwaXv4kXDNsK/JgD/PXqWOkkHRrWMJiIpEYNSTm+XCGeYlJVVqK6
         KqwlEYYtKzQinzcbvRb0xYFWgW7ZKR/9ApHK1fMBoad0NBjQNh6U7Pdv9XyINPKIsBQN
         E7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729351942; x=1729956742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMbXRc4YDc45MT1d2qKMPKKlX3fx86b90pw720KiDfI=;
        b=IeMElZdPF+mOUV+P8Ny0Y0rqfd78I678T8BADbokmVjLldu0JLmues6zIHVuCO/WoJ
         zlDPX7sjNvNxY7gRsVrxxJuI9Pwb41X9iSsD/OKsNP1/qMTmXz1hbGzwdThgPaiJaRny
         USJxrvsmu0klFhl+CmCf5yomKhLv1BK1EVGS/5CEA6hfMCV3F2voLRAuo2rsA/9X47Be
         FUfuO6dtXIMb72OMmaEyg8T1EJUsmR1prSnaQv11seMeU9LYe2cql6lVkhvp298nntgg
         M+LIfHKxPfrxXMNRumGbv/lkFEmjsIsRLK9PcWCBwz7GfL7FT7xJkNffhncAPFDpLp+8
         1Vcg==
X-Forwarded-Encrypted: i=1; AJvYcCUn7NNEnm5vQN389MsZeckeAKZoMTh5E7nTftzSXOSHsmKCatXhiPUwi0GvPogWZMb++k9KlVWbl3n/VEwR6wY=@vger.kernel.org, AJvYcCXlgPwjrMPsXcrk9LSDQ6eiaW4rZ061DDQ9/BbvALG4YZwlmxBvSOd3PcvVTrA8WzH3KXdbUnfffqWqh7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6v4ayLbGWfc4urG3YZN3jn/lbiul8jXzBDOXPbL1d/+PkEXuO
	vzokL5fsFo25RqEuwFhopUe15jWoWmGfF4+kLwltM6XOdeYAPc3NAsn6bj7jcjy4YvVemzugzBo
	3FmAcVemoWmfk/1Q0Vsub3Z3cEg==
X-Google-Smtp-Source: AGHT+IFJna+hBKXImW8Ukhf2hjuSYeoPJcv9SN4RAswAP5PzwhWWEEM29I8Tn+A3FSx/U4+sO1kd59bFe5ksAV0udi4=
X-Received: by 2002:a05:6a00:2da2:b0:71e:6a99:4732 with SMTP id
 d2e1a72fcca58-71ea4255c3emr7246225b3a.11.1729351942310; Sat, 19 Oct 2024
 08:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801202359.794035-1-frut3k7@gmail.com> <20241009065051.51143-1-frut3k7@gmail.com>
 <b58b5b2e-bf9f-480c-810b-2cef29aab82c@quicinc.com> <CAKEyCaDUfn4jtCdTt9JJ-Qe+CCudORPwcjj5i5=G28ANc+eCRg@mail.gmail.com>
 <87ed4dr5pj.fsf@kernel.org>
In-Reply-To: <87ed4dr5pj.fsf@kernel.org>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Sat, 19 Oct 2024 17:32:10 +0200
Message-ID: <CAKEyCaD-1GO1NL-=1E92BE9=XKa2PymOAY14vMmtwYGLsPjeUg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath10k: add channel 177 for 5 GHz band
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:49=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> I wonder how this works with QCA6174, unfortunately I'm not able to test
> that.
>
I only tested on QCA988X, QCA9984 and IPQ4019 as clients.
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

