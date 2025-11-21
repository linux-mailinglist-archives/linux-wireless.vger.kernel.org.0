Return-Path: <linux-wireless+bounces-29233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B03C78ABB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 12:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8072D33B7C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386FE34AB16;
	Fri, 21 Nov 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hplU1Cm8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337234AB07
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723031; cv=none; b=ZJudYziCQD0plK+7iCc0DV5fn7gBbqfCSstvWe4iJmNZv6kESxLICj7WbYLfKg26sr2x6b1JBRljKfS2Hq93y8jB5ZmAguzqEnNxXRLr2HuxfKx7PGz6HTF0s9HcNdQ0RD+6nDv9fV6KzdIbd5KNzA7fPpH5Ovvv5BrjCdkMvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723031; c=relaxed/simple;
	bh=jKe7BHgsupWRT8zF9//LN6lIRpab6XbItrhVbxZ6Aho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBtbbsNRPH68MNXwRIminygmdROXQ12VOJB/FwnmPiNmLnP90HNA16jg3UK+YQ0Hhn3piZKpyTZEbK72SYq75CCDxDfhzNWgA1uHjOAUJ7pw6PL7jmkuF7md/M+VDr8pXTAa2mEC15BshLhv835iXTUia/DQc+yd+IGEBVNkiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hplU1Cm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BFDC19422
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763723030;
	bh=jKe7BHgsupWRT8zF9//LN6lIRpab6XbItrhVbxZ6Aho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hplU1Cm8gcRCe0Dk9v3G4cp9fKaCn3H/kilV8hRIToh2Ddr5GMq9krEza6JLSwaYD
	 UPUSZm/er08Ay2zyISxm3i7vp3jzZFbgqLqoOeC3eSI97OIqXGbXw3ycYVnBY9bStu
	 dVHPcFMhExPeDm5UutWBlXB8mTns5ZiCVi6BfTLYIzpVkAbSnSHM8UUz3qNx842gqQ
	 ya59WygTbURoKf6u73iRhBKHX/sq3q0gj334yDT/lVKUoYkqTUpCK9rk2yuwBmbkxA
	 9dhTuoKoPEjUMM/KRX3EAMX8hxKw6FDnhEkc4+DJlZ/13RzbGXiU6wTm+2WGl2wona
	 ZV9PFYWYnbXoA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5943d20f352so1926612e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 03:03:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3UwweCnYGyU06nghfYEX5i3c5sfrAe52hpTtjVWJfbhBLkUSHmf5JRMQNt9WTt0R8KD3i0LkX0PCl7GGV2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSvO/ug/nM8c6zLRFHZ0CQCmYm9gbly9QXgiz3vs33YFuAaJ7
	/PJ2ENhxdZaF00Vn1EWKg+Gf7pw9IJ0BolMr5/4LzhU6fyKKANn86lrF1QdltxJOCK+zsW3Qv7p
	RJMPmvTwVUb+K95+Hd0HenSUdGpVUOp8=
X-Google-Smtp-Source: AGHT+IHrmZs25clhs8UVGUfOKEt/s8CM8NuuTNPBnJADE6pBfKAM2tOoXhXV5hZlWGB+IGOopiydEFsmkLa4SW+J/No=
X-Received: by 2002:a05:6512:1389:b0:594:253c:20b2 with SMTP id
 2adb3069b0e04-596a3e98328mr675359e87.5.1763723029124; Fri, 21 Nov 2025
 03:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120011022.1558674-1-Jason@zx2c4.com>
In-Reply-To: <20251120011022.1558674-1-Jason@zx2c4.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Nov 2025 12:03:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFB8nvDrv2Pz-X12vqxWvLReFVVkXgoGPpjdkGFbQbd=w@mail.gmail.com>
X-Gm-Features: AWmQ_bkmvVuDn7d2i1HC3zF3BSK0e5JeBoEGmkzt-36Sf9P6xqQjV9duCM6hj6k
Message-ID: <CAMj1kXFB8nvDrv2Pz-X12vqxWvLReFVVkXgoGPpjdkGFbQbd=w@mail.gmail.com>
Subject: Re: [PATCH libcrypto v2 1/3] wifi: iwlwifi: trans: rename at_least
 variable to min_mode
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Eric Biggers <ebiggers@kernel.org>, 
	Kees Cook <kees@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(cc linux-wireless)

On Thu, 20 Nov 2025 at 02:11, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The subsequent commit is going to add a macro that redefines `at_least`
> to mean something else. Given that the usage here in iwlwifi is the only
> use of that identifier in the whole kernel, just rename it to a more
> fitting name, `min_mode`.
>
> Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
> index 5232f66c2d52..cc8a84018f70 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
> @@ -129,7 +129,7 @@ static enum iwl_reset_mode
>  iwl_trans_determine_restart_mode(struct iwl_trans *trans)
>  {
>         struct iwl_trans_dev_restart_data *data;
> -       enum iwl_reset_mode at_least = 0;
> +       enum iwl_reset_mode min_mode = 0;
>         unsigned int index;
>         static const enum iwl_reset_mode escalation_list_old[] = {
>                 IWL_RESET_MODE_SW_RESET,
> @@ -173,11 +173,11 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
>         }
>
>         if (trans->restart.during_reset)
> -               at_least = IWL_RESET_MODE_REPROBE;
> +               min_mode = IWL_RESET_MODE_REPROBE;
>
>         data = iwl_trans_get_restart_data(trans->dev);
>         if (!data)
> -               return at_least;
> +               return min_mode;
>
>         if (!data->backoff &&
>             ktime_get_boottime_seconds() - data->last_error >=
> @@ -194,7 +194,7 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
>                 data->backoff = false;
>         }
>
> -       return max(at_least, escalation_list[index]);
> +       return max(min_mode, escalation_list[index]);
>  }
>
>  #define IWL_TRANS_TOP_FOLLOWER_WAIT    180 /* ms */
> --
> 2.52.0
>

