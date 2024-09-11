Return-Path: <linux-wireless+bounces-12781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A699749F7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 07:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9C91F2683D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEE542052;
	Wed, 11 Sep 2024 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuA+WW5t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857940862
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726034003; cv=none; b=cxh2TEQxyuG3PoNLJuqQ/yB5fAL1fqv5JqePo+PDVI8fzeDByeZR03e5czCNSYRcZzw6zfdONVcGwZxZHVyNDP5wE0I+nzI91vxA4FWATHd2l9zOIYRtXe7OVhrRIZbgM1SlwAP0vJMzIboVdLZzLyHz0dDDGpYF/VMIEdXhSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726034003; c=relaxed/simple;
	bh=bJLrTEng+6Jx7oKK3DNfPjxsGDrJ5KjOSDCymU8hD2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3GE4vbOKb1OFdH7CDsKQOYdNbIbOzGX7//gDOZ57UZw7cOdy+7GTuKVUQCVFLxQcXQN3Kflq/n+Z0UVN4U7vcxG+2NcIq5gKutote/7zVTEuMcGZw9vIluRG7u5E+0GuC+co+9DSRjPIpM3Lzc0IxjuOe8njDMrufF1xfk6GXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuA+WW5t; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so379212966b.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726033999; x=1726638799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJLrTEng+6Jx7oKK3DNfPjxsGDrJ5KjOSDCymU8hD2o=;
        b=GuA+WW5tkoP+PqX8+66sQ0/VBfAV+nCtaSCgkqobNSGAXg2Fs2w9b0kxI5CSr4yI62
         0h/L8gmAw2d/BI4RjjRC+YJGcvEYFWQbexA7ObjYaOuqMcuaVrW2Qd2wVUtOsLcUgvty
         lXpmvoSCTJ7Nv4B22Umbf4kzrkwR7jWjC/V20izo4E6THp3UmRkWOlzc+PEbrlaxHhKM
         sYMVZMDHoqQKP+HX6SqVqbEZeAO5wRVgt++JrsL9xUUSmYrhCOtYFOyarzRdwYISAMRv
         VgIxgjMEKOp7ebKz2MEvhTNMzXUUzGHgh3T/EZLE7jwj3ldEOpWug7O0S14m2R8WoEDR
         MW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726033999; x=1726638799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJLrTEng+6Jx7oKK3DNfPjxsGDrJ5KjOSDCymU8hD2o=;
        b=qckQ3j7rJZvpaX5u7sP/ogjuvjg7t5bAaOSpbMq3hUVUKc8BygG79X3XRfCekeRE0g
         j2w2yZWkp9beIuw3Ld/s8AQkZQLKJvWpKHJcYC9KnYYb+HznemLzLlX8S7Am31xlkE7F
         FpiNASLTKSMR3O5Cgdfd0zpH3emWMXFKHyNvNR+z7miV+cke6M7kF28GblEOUOKBJPEe
         HLLLn0tOvNSlAQS5h7AxCwMZdz2JtkwYIU1Cc/UKGD/Qxtucu0kNp2cx+7LrOIzu692v
         G/Bb4iM9QM70Wf2MNrw24e1lhewgRz9pu+VtD+IRaw3twei1mR+ov7E2qcui8CNfF4J+
         F++A==
X-Gm-Message-State: AOJu0Yz+k+k7Fz7RqtcPYGbGbt4L3lIUc/u7uXo5PBnVOHCqsDL59YwX
	ZJvSGjC3vSh9iGpsQrKZJxQL/Vq7h/Xw0m01ksj4/0SOSFfXFZzvrR1J30IChfiWDfOhg6b8sYU
	OHASvOTHIutoowCmSNAlsm3sX69A=
X-Google-Smtp-Source: AGHT+IEYxeCzzwzF3KQtrk4/6mHLEV4G0TwzNALY82kLWkdFzVqRJU0JkOAmC6t2WpbswtPGXetSvACEbVjuHgRRLMg=
X-Received: by 2002:a17:907:7d87:b0:a8a:9207:c4c1 with SMTP id
 a640c23a62f3a-a8ffae0ae15mr283232366b.58.1726033997782; Tue, 10 Sep 2024
 22:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAWfyLVNrCzYoACGt2zAJ5K5FnBJkDmHuVAfmScQ3=_ahSEbw@mail.gmail.com>
In-Reply-To: <CAKAWfyLVNrCzYoACGt2zAJ5K5FnBJkDmHuVAfmScQ3=_ahSEbw@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Wed, 11 Sep 2024 13:53:06 +0800
Message-ID: <CAHrRpumE7KsEDaF+Ec288q5xGGAetVAfg4j8TGd_cLqT2MDFpg@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Indonesia (ID)
To: Zulkifli Izoel <izoel21@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Zulkifli Izoel <izoel21@gmail.com> wrote=EF=BC=9A
>
> country ID: DFS-JP
> # ref: https://jdih.kominfo.go.id/produk_hukum/view/id/862/t/peraturan+me=
nteri+komunikasi+dan+informatika+nomor+2+tahun+2023
> (2400 - 2483.5 @ 40), (500 mW), NO-OUTDOOR
> (2400 - 2483.5 @ 20), (4 W)
> (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR
> (5250 - 5350 @ 80), (200 mW), NO-OUTDOOR
> (5150 - 5350 @ 160), (200 mW), NO-OUTDOOR
> (5725 - 5825 @ 80), (200 mW), NO-OUTDOOR
> (5725 - 5825 @ 20), (4 W)
> (57000 - 64000 @ 2160), (10 W), NO-OUTDOOR
>

You should send out a patch to update the rule like others [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/wireless-regdb.git=
/log/

