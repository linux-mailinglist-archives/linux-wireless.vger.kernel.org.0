Return-Path: <linux-wireless+bounces-828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516C8146ED
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 12:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE24C1F234AC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C57E2555B;
	Fri, 15 Dec 2023 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="cWcHlnsY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202525546
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1702639802; bh=EAmGaqmKjjG1AL/L/BZqC3Ph6MjkzfRbS3bZYIUtwZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cWcHlnsYXiZO9z3lZZbO9B4HtIrI/wSPCTkrBdjw6w9a9nV+9IhcmMQ4hrorP/Ke5
	 YCSsJNTDvzbGrsV2vm+P2GZBAf54A5S9pmpSCfC9MQErUl/jYhG7VnOHX4AfA0NaGl
	 2+HBKyq1CIlWKf7VTAnKpJz8eQDb1cjIJARJbeXXQw+TUCsGfHMlJwpzrucaaKVvLa
	 zVVvhkMpawLxVt16AAJR0LUV5mB0RDrL7APOAadSXjMIm3GhA22T5q7t9m5DZvVbx4
	 qtwtjRlMNsdVQVBeVWQtVxGw8fAEb6OgxppHWOsttZvWLEiqLVvx2CKU911Qd89K36
	 81ZCqtVS685Cg==
To: Wenli Looi <wlooi@ucalgary.ca>
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH v3 02/11] wifi: ath9k: delete some unused/duplicate macros
In-Reply-To: <20230629231625.951744-3-wlooi@ucalgary.ca>
References: <20230629231625.951744-1-wlooi@ucalgary.ca>
 <20230629231625.951744-3-wlooi@ucalgary.ca>
Date: Fri, 15 Dec 2023 12:30:02 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878r5vzosl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Wenli Looi <wlooi@ucalgary.ca> writes:

> The rate macros are for AR9002 and not correct for AR9003.
>
> The AGC 3 macros are unused and have incorrect values, at least for
> QCN5502, where AR_AGC3_BASE should be 0x2de00.
>
> This change does not appear to affect the final binary.
>
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>

Seems like this patch has value independently of the rest of the series
(no reason to have these unused and wrong definitions sitting around),
so let's merge it now:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

