Return-Path: <linux-wireless+bounces-376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEC580324D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 13:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50A53B20A47
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321DD23777;
	Mon,  4 Dec 2023 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcEDU0RA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60623760;
	Mon,  4 Dec 2023 12:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F13C433C7;
	Mon,  4 Dec 2023 12:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701692187;
	bh=fc/FTHJIR3OE8ibUODqU3UGV2wgertJeCOgaje1qPgA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DcEDU0RATDwbEkEUo5QMJpTaaSeruSNmxpEF/b6F0PSPJItD4Hii6Gpn0HPB6DttL
	 wgZeIvv3RFoMJ5SUjEZFQgLOxEnCsWG8tJTARCMJicm+K7xzSLXhstdd7nnaSMQ6Nf
	 JcZMPAwPtCKMIHZkhxVrjsg8j2xG9USuYhsJGoyvd7NJbVYoekk7nMPBPgPqs1UGA+
	 2yhOVxJ2LkUdGdrUS1CIfa084PImSYHs3h7rSKSerW0wWm4yP8yINoZ9IbgFksO0PO
	 iPDggsbClUzBLp+1BWC9Gv3uIMqHfOHsswbsh8PP3yGm/tYGWC9/Rne2req1pk74Y3
	 xfG+h8lZWrsOQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath10k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] wifi: ath10k: Default to board.bin for legacy board
 data file
References: <20230825202610.1580132-1-dmitry.baryshkov@linaro.org>
	<87pm3afjda.fsf@kernel.org>
	<CAA8EJprZvCtCKoV4J=21=2+fDM1gTfJBOThj13J3sE0w5AqpPw@mail.gmail.com>
Date: Mon, 04 Dec 2023 14:16:24 +0200
In-Reply-To: <CAA8EJprZvCtCKoV4J=21=2+fDM1gTfJBOThj13J3sE0w5AqpPw@mail.gmail.com>
	(Dmitry Baryshkov's message of "Sat, 26 Aug 2023 16:56:43 +0300")
Message-ID: <87plzmqi1z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> On Sat, 26 Aug 2023 at 08:44, Kalle Valo <kvalo@kernel.org> wrote:
>>
>> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>>
>> > Default to 'board.bin' for the legacy board data file, in case the
>> > hw_params array doesn't list hw-specific board data file name (e.g. for
>> > WCN3990).
>> >
>> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
>> Could you provide more background _why_ this is needed. What are you
>> trying to fix?
>
> Sure. For wcn3990 we do not have the
> `ath10k_hw_params_list[].fw.board' set. So if the board data is not
> present in `board-2.bin', the driver will skip looking into
> `board.bin' and will error out.
>
> I had two options: either to set the `.fw.board' in
> `ath10k_hw_params_list', or to provide this default. Granted that the
> check for `fw.board' also prevents the `board-%s-%s.bin' lookup, I
> opted for the second option.

Ah, now I understand.

> Maybe I should just set the .fw.board to "board.bin" and
> .fw.board_size to 26328 (?)

Yeah, I think that would be much better to set those fields for WCN3990.
Please also include to the commit message the description you wrote
above.

I can't remember anymore why even have this struct
ath10k_hw_params_fw::board field in the first, most likely due to some
legacy reasons before we had board-2.bin. I suspect all the fields even
contain the same "board.bin" string so in theory the field is not really
needed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

