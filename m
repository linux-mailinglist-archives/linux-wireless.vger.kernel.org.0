Return-Path: <linux-wireless+bounces-423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA29805684
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 14:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76709280A57
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D25D91F;
	Tue,  5 Dec 2023 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnVf7x6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A75D48F
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 13:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD895C433C8;
	Tue,  5 Dec 2023 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701784304;
	bh=a6xS3z6mtLFaeTZpe8xIR4gG2cDNZqCLFwl0J9kQ+gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FnVf7x6Mtl0mcGs14WSkijPvLJvs2fhCQBobmzk3TbVtdXLcC4RSHyxWCON9d4U4n
	 CJEke4CM9PzzW4VEzOXaf6DR+zUGBduQ2S0axr2tpMq6jBCpT+9qt95zRSlMK5RniM
	 yRy0pELfoAfNTRBIXR7Qd4A6kmrRBrswoYfoXyWQBdadcNAJkQVqhsDFvq2KLpafQJ
	 Hr9FdBCZ2xi+UTSxZsGfw0TAJJtb9HZjjnwVn0LtqtHzfyMUi038vUuQiG8GrW+ikh
	 JT3dTAJOZu8My5LhOuucAfRdHfJJ2hJ27PRMfufLUCmVIwPRhQhtaMW7qJk9zshsQr
	 k530kPwTKSV/Q==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6D61AFAA56E; Tue,  5 Dec 2023 14:51:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Hancheng YANG <hyang@freebox.fr>, kvalo@codeaurora.org, Johannes Berg
 <johannes@sipsolutions.net>, Jouni Malinen <j@w1.fi>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath9k: reset survey of current channel after a scan
 started
In-Reply-To: <CAO6a22XGGZrja47_M6vQBh0sOw3gMR83H8TcAE8FBJ=Zsd6+ow@mail.gmail.com>
References: <20230817092900.361270-1-hyang@freebox.fr>
 <87wmxtby1g.fsf@toke.dk> <87v8cutbra.fsf@toke.dk>
 <CAO6a22UrmZ4b+7gBSYnsUU3qUScKwQmBGA_vB3gDfh2C+=1BWA@mail.gmail.com>
 <87wmx1m2mf.fsf@toke.dk>
 <CAO6a22XGGZrja47_M6vQBh0sOw3gMR83H8TcAE8FBJ=Zsd6+ow@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Dec 2023 14:51:42 +0100
Message-ID: <87v89cahap.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hancheng YANG <hyang@freebox.fr> writes:

> Does anyone has any idea about this issue?

I guess there are no complaints about the approach. Please resubmit
without the "or there's a better approach?" comment :)

-Toke

