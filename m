Return-Path: <linux-wireless+bounces-8896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08551905BCB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 21:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B148E1F21668
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB9C57880;
	Wed, 12 Jun 2024 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de/3beha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09FC381D1;
	Wed, 12 Jun 2024 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219765; cv=none; b=vGj9qoDwdFBD2Umegk6WY/6YyrmJPdVg4oDdxQ5QljGnJr3vxw1ltExcRruobS0pq1TVJAi8MJ/lzscyfGPRBfvz73S8s6GQkgEdYFyop3EpMNaB5n5n7QrxyTQSGkWyf9EHJs9bqEd5Sd81SZb4bHEtYUxlMcN5DBZS/lFF3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219765; c=relaxed/simple;
	bh=A+VpfNhkNXssJl8SPNJS+OQlIAJWkhecVNtDnhP3BmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEscHBfXwjT7rLLKMONRHmcweoPo8Df3a5msrSViynBrUJ21U0sICWCR0XKlal5o9LzxePyvLgDQF0J2wFYrSACOuocjjFuayESzHiNjxBJvIJ4PlWUAgQ1QMgESkc4PIS32ImxKy9xfFKu95FXdL205+lQr1xLRd9ObPW4AlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de/3beha; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6f38b6278so277195ad.0;
        Wed, 12 Jun 2024 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718219763; x=1718824563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+VpfNhkNXssJl8SPNJS+OQlIAJWkhecVNtDnhP3BmU=;
        b=de/3behadMnFpTa2JI4KRbO9yht4qFRym9W+YaIfaAcE9EsokaLfqwv2AwFivoJO3W
         GYWONshtt2tayYTD5BZqegzHxZBCYCv4jpw+dfD30hTqSl/DzR4valucEzCjuBy7Gmuy
         M7b7oCSprDewHeJ80fN/2J3roptnA1Y8In2eZtXYCUne6PDb0MzG7VhcBc/vOZXqzkJ5
         GsyU55eKrMqHzbYw2I/7XiSwH9ZFiYU2s6vysYksEJJRGoCqIyZpyFhuyr/jCfBRV8n9
         m19dgA1sbXUWSZeBoxAuIpQP2XMliymiP3RAla0AyCkVT30+eYk5bBVZ9HNjgK0I9NR2
         EHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718219763; x=1718824563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+VpfNhkNXssJl8SPNJS+OQlIAJWkhecVNtDnhP3BmU=;
        b=SiyYGW4uj0jDFoLHFMQKNaVITUgyHhLEAPQYBkj0NzNzLorFQ/o4/qHj6az07Dhe+N
         iwDXnIBCsjinCcsM3lrj28egpYP9wmgiH3aT6qiuONBOMNih2Joyd0gw/eXDYliiRdEr
         0lPTfkuKVTUsVSiEzotH9zYgqAh7d6FML8LM2/WhkHNqUInhwmN3yOblgtdXSBLNtRuv
         orxlSLjBxERo0hhA+GOC8AOObU4DkTthfd2oN/ANYsZvvPI9Wajgs4pXJdhjFG2rjtEi
         HZEJl92CznDH+/wxcW96p7OgPQCGoxAA0ensHeXU8AvYj/pwbO8ds65Z6tiaqKJ6x/wS
         P+/w==
X-Forwarded-Encrypted: i=1; AJvYcCVkAAWf+QNUYRcI6wnltAOuciGupoUAAbMfTl+IGezejo3cYjDw8mlgWoAYxQ4fC6HlxMfupjsSVh77t6Fwu1qG2G/F6EGBLLnQAVhd4MWsSKKpbYjgsQYT8RAiGLjFo4wMZYb3qDsZ2/xV9ag=
X-Gm-Message-State: AOJu0Yy56HE+xsGjcu0jxMf564ybiyijKrQyzMBSpLXrZkDFp9qJ+8IN
	tbLh8WVSXmnlZBlI37xaT++TmaikFcCpdTIx7oT+DsvGU27f6MjCT8mAb2lh9Nw+gPvRyAse5p9
	TvcEMLx0YL72JaWU14WZNMFPwLoY=
X-Google-Smtp-Source: AGHT+IEz12pJOJPP4SRJM7X37Q5Q/PBHs8l5ZKRIH+idUXzto7zy5Roy+kO8O4ZOVmAX1ew5P/R2FzaP+3uYKsxiQWE=
X-Received: by 2002:a17:903:2444:b0:1f7:2576:7fbe with SMTP id
 d9443c01a7336-1f83b7328eamr29256795ad.5.1718219762849; Wed, 12 Jun 2024
 12:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
 <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
 <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
 <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
 <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com> <fb60b7f5bcf5ba47be54398225075a5bfab7c141.camel@sipsolutions.net>
In-Reply-To: <fb60b7f5bcf5ba47be54398225075a5bfab7c141.camel@sipsolutions.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 12 Jun 2024 16:15:51 -0300
Message-ID: <CAOMZO5CMX_juW4-t6CSd2xdzXkFfBiamuSTjsTB80Ly_TUsxRA@mail.gmail.com>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
To: Johannes Berg <johannes@sipsolutions.net>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Wed, Jun 12, 2024 at 4:10=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:

> Strange. Is there an IOMMU involved on this platform?

IOMMU isn't available on i.MX8M as far as I know.

Interestingly, such a warning does not happen with the 5.10 kernel.

I only noticed it yesterday, after migrating to 6.6.32.

Thanks

