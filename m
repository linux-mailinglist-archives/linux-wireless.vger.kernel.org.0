Return-Path: <linux-wireless+bounces-24208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DDEADC95F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 13:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECB13B4242
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 11:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95722DF3CB;
	Tue, 17 Jun 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH0bVO9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511451EDA3C
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750159856; cv=none; b=B3Idy3qXU7EAv674K5q1gzUy0XY/5ClpSRn12sxHs2fnq7Q9WcBlHpbAOiRip+b1Q5SduZB58g17jabks/W1YzaU0Eti05RcYxMKVsF//7/6o625t25UlzRfu8HndcJMc3G5Vrya5qj+N2MVHH3iIxmjWIH4b6BK3clt8Gqw/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750159856; c=relaxed/simple;
	bh=bNlKTo7LWbYK7UlbTHftApANVR5DoTo5OzkT18J8z7A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PYM4fiAJWqWvR8Mxu7m4/FfBLYeT6MWOFBVOnDuu9d6sOqiYhibzBNmzacJC5dT7moRWD+cErRxOr6HJRHo+Ln0rj6ARXXsR/SPLRhOaC3J9SCQ/MxDarnsFmneoQmhfAgEi0yUj40YHFQVQ0+UFAOG2i5MmkAVzQVy2QCEtK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH0bVO9/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fac1c60e19so68539666d6.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750159854; x=1750764654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJPaK+b3PlL6j4vF1vjvdiIRwvx5vJWQyOToTB+3tlg=;
        b=RH0bVO9/WfMccHRISjABxNCsQqTZTzJoiJ+T7zwYn/te9s5oPqHxkFYU+4XA4rSMoE
         n4Xj/DmoGKfsT518yJr0ZZXVGrLcSPfnue8LVB9bIQR1/tszJhugHcnQPEbIJLJEIUXT
         HY3osIpJtqo7Pl+UcHxVZD0t/n2uBJCcRJ0/0ZfQCbvXV6f88HqazeSnxsR5pv8Ay8pX
         XcyPTRfjILIoxWnepn+88idX7i3wsAOxReCNNUnLU3rVd5hQLxGoJZMRx24M6Acxv58d
         KeRKvwiCppRbeZeN1ugCtyYc80NGKRbfVow2cCUPJb0JdrCqR6hv8YZx5coYJ6Dq6O2r
         Jl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750159854; x=1750764654;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NJPaK+b3PlL6j4vF1vjvdiIRwvx5vJWQyOToTB+3tlg=;
        b=MRSEt2B5o19Jm5UpeEn0ggem0tfbcmXqkSwnDZoCGlbWddM/CSW7cD3XajGh+ywBTv
         EbIrFaQDlzRssmjtguVR1UEj/741N+y+zwpUlZvfbMIeq3w7UlJQRJPNksNahqYmh1S7
         wBV4VMuj7v8rRvBZHd/dcNQYrlzUI5fHdTJ7zDkUQ//m2v7FeLIYfWvesCiDwbXCcYsw
         G810QbwHs47MpWOajLQ6wZVwZ9TdwQNlo5XKmCJsX2woYeOQb4L+ZRK4DAwFFgcABsyl
         VloGp2X74sJR6/jFyxUycCH3iuDeCBWxBTbo20kV2VFDEsHp37XgvAxrePXTM3uipVdO
         Ekhw==
X-Forwarded-Encrypted: i=1; AJvYcCUkOru8ngDTAFr8Fq6jTx8wYjD7Jr9QQmfP5UKDqHzdNH1qZCOG2g5UIXlcFrUsE8tnrC4Uat8TQjUPhl7r7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VX8M8zDvxqWtCk1UL+XKiL3sdhhERJ8TUzTew75IJ+VAvXfp
	kJs34x3HjAdYxCz90TlcYnasbSF0zxwD3/FZEepyqrppXhU3a/A3TlY=
X-Gm-Gg: ASbGncslQtC74tEnFBwt0wtLZ0VXyR1+ADQ/g/2sHPTSWUcepfIdwyyDnIxP8xG5lh1
	X0nb4rb1DiL7VvEaWv+X4TU318f4inn6VGuL/evaET8ry3g6EJERhwn3QVKR7URBybL5JlU273L
	Hf1V4sGI7HZrSdK6h1R0WqAcS7LIpaqPtT0bYrTrayaB0biQHjzdXE3RNlL8FF7+uCjYBZM3i3J
	i0zDfqaoX55zhZoCVKjAGcMNLJWS4VbJHs16msrl/akQAUH9jvqj6P4iwO0dttBX5YDlCFzDg6O
	2R5ZewUseN4gl4e4diDTyc0Y8XN8WU5wcZhJSWwSMFmonKV3B5qRXZAvx4rzhfgByrFeZbMJ/9d
	CMbjXVOjE30WcXhHlS9dSj2SS4Q==
X-Google-Smtp-Source: AGHT+IErsgkq5FfER0lPl0Olu8k8AJ6sQFroHTyRR/oGk+cfcpM5Bby+LyJ6mE7ty86J4OJ5I60Naw==
X-Received: by 2002:a05:6214:5c88:b0:6fa:a4b7:c664 with SMTP id 6a1803df08f44-6fb5eaccc0dmr34189616d6.22.1750159854097;
        Tue, 17 Jun 2025 04:30:54 -0700 (PDT)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c4acb3sm61596666d6.86.2025.06.17.04.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 04:30:53 -0700 (PDT)
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: dvm: restore
 n_no_reclaim_cmds setting
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20250616134902.222342908ca4.I47a551c86cbc0e9de4f980ca2fd0d67bf4052e50@changeid>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <9da7a402-bdbc-5585-0860-523b519d6b91@gmail.com>
Date: Tue, 17 Jun 2025 07:30:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250616134902.222342908ca4.I47a551c86cbc0e9de4f980ca2fd0d67bf4052e50@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Apparently I accidentally removed this setting in my transport
> configuration rework, leading to an endless stream of warnings
> from the PCIe code when relevant notifications are received by
> the driver from firmware. Restore it.
>
> Reported-by: Woody Suwalski <terraluna977@gmail.com>
> Closes: https://lore.kernel.org/r/e8c45d32-6129-8a5e-af80-ccc42aaf200b@gmail.com/
> Fixes: 08e77d5edf70 ("wifi: iwlwifi: rework transport configuration")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   drivers/net/wireless/intel/iwlwifi/dvm/main.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
> index dbfd45948e8b..66211426aa3a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
> +++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
> @@ -1316,6 +1316,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
>   		     sizeof(trans->conf.no_reclaim_cmds));
>   	memcpy(trans->conf.no_reclaim_cmds, no_reclaim_cmds,
>   	       sizeof(no_reclaim_cmds));
> +	trans->conf.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
>   
>   	switch (iwlwifi_mod_params.amsdu_size) {
>   	case IWL_AMSDU_DEF:

Thanks, it does fix the problem.

Woody


