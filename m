Return-Path: <linux-wireless+bounces-382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9868039C9
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 17:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F581B20B01
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC212D627;
	Mon,  4 Dec 2023 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9ndRfET"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE55395
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 16:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192FDC433C8;
	Mon,  4 Dec 2023 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706243;
	bh=fig6ieXW1XulwQyCT6GtiXhbfC/2IiymZ4gHvMLq4n0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=X9ndRfETgBPRCQnSBGKLV458fEQI04b3+8qi+CsvqwIMrnhB9htMN5uBpartX2m3E
	 sv/EZzL2bYJr/1mc2qEjoAU/Mli436R4obJnnKR5MqSmbrHWaEu2uDxQnjvEjC7tPI
	 nlOMHG3WR3aaAMcVfViBub8h0VhKkV3GP+DHtZDlN3d6cBNqkXOFUyW1gFk5s2/Mvy
	 ZoidaXiEvyCQHS/raPNERzK4RGWB0KiazcYAp0bMZSStq+XqXC1ilSSo7a3XYOZvin
	 quQlF9hVfz9WYnpOxFztcnV9wv44KtsrCznZSXOrCN7FvE8qKKHZLq17h+6LCOVuYJ
	 q5zWB0aWIZLGg==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wfx: fix possible NULL pointer dereference in
 wfx_set_mfp_ap()
References: <20231204155558.133839-1-dmantipov@yandex.ru>
Date: Mon, 04 Dec 2023 18:10:40 +0200
In-Reply-To: <20231204155558.133839-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Mon, 4 Dec 2023 18:55:37 +0300")
Message-ID: <87cyvmq77j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Since 'ieee80211_beacon_get()' can return NULL, 'wfx_set_mfp_ap()'
> should check the return value before examining skb data. So convert
> the latter to return an appropriate error code and propagate it to
> return from 'wfx_start_ap()' as well. Compile tested only.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Patches like this should be tested on a real device.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

