Return-Path: <linux-wireless+bounces-7938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF308CBD51
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F91B20B9A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E58060D;
	Wed, 22 May 2024 08:52:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBE77105;
	Wed, 22 May 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367948; cv=none; b=trZeXhJTtg/61ToES93glep/B7Qg2oE/wNo0V+zxifsL2kH6hiGx+4HMoMlYzHysgDAPF6nVMuOKuX6GI7eu/q2lr8jHOlwtK9G1T84TZ4Lohg3x73ebAyev6xKMFLTg5UEqwm0J2Rg3nkl8acWlta4iNguOKpl4lyAMZf48aHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367948; c=relaxed/simple;
	bh=W3ZhG/YZWLgP5RFoD6VsaMBgMUEM2xEDn0Z9IoIgWIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asf4lbn9SO2leVvvcGxO9tqn6M1c3dniJUGB+nvKsvXDPAh6Skwd6pxKqhRi9G552CXL7AfLTcnZlgDAFq0hqm+zro2GteyM4Cn4Fxc5QIwCJXsB8Ohw44Av2fqMvLOB6pqPnzOFKXJzqODZ+z45iBlW+5NnXriNyZ8Te4AxNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52742fdd363so162516e87.1;
        Wed, 22 May 2024 01:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716367945; x=1716972745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpSmewLWZYVUMb9xmY8HpapTlOuf2q5t5h6eI02Xp5U=;
        b=JrzN+al2L/5RnKQo/nd/QwUlNevYLCxiQlktWLFraI44BjNySB4S51EUgpr8pRwlur
         J6bAcZCek2mdCYc+huTYCBIHAHk7YUy3YopocPMnILHYaxJnbQANR+gmB7aJ5EJzsl7i
         OwVfUTVW0YkK3GYYfrhx/UjpjzHP/OxQcqeN61zT0/SpTkQ4Iv3bmZcRl9IcVM+uQTLT
         bmlW6MI9vagqoOy1te1y199JRk/D3TjH6aw7nsbhiJGUlcv3E+KkvHnbm/zrbG/hm5pF
         tiviRKMpHAriyIb6BJoTlX10KhdDiRWs1PdM6p5bBLKMLvNzgq1s5JgyuohxAn2pXaIK
         +KeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoVcXfRvjhuE4aRqIuSkaDJkvuU0IIx3ezuMhoPt8rEtmj3Yz3bFvTxSjA0ynJ+4zON4H4gQtVZ7rdUzFNxltYsSr6YaEeGrz3TqpssKCWRBfaHHPTvFdDDEy0J2N/bbJ1bfISUaBdNrNcRJo=
X-Gm-Message-State: AOJu0Yxg1/jY21nnApwsg45vC3tio3sGimQMWkV6CtBZcRY+YHFi0mif
	5GFN6D5MAhMQUm4nmC9Rct31/ij2XZdt+jM5JOFDYWJ2V0O4I1pm
X-Google-Smtp-Source: AGHT+IEm0D0PsZDvzOYLVHisk//K8OR7zS9pISgp9kaOoVDH6b58MubkIX+n8+g7y4xx0dQ/0gySkQ==
X-Received: by 2002:ac2:52b3:0:b0:524:6cb:586b with SMTP id 2adb3069b0e04-526bdc526a2mr809613e87.23.1716367944881;
        Wed, 22 May 2024 01:52:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed0af0sm17995239a12.49.2024.05.22.01.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:52:24 -0700 (PDT)
Date: Wed, 22 May 2024 01:52:22 -0700
From: Breno Leitao <leitao@debian.org>
To: michael.nemanov@ti.com
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH 08/17] Add main.c
Message-ID: <Zk2yRqFIUAhfOgTL@gmail.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-9-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521171841.884576-9-michael.nemanov@ti.com>

Hello Michael,

On Tue, May 21, 2024 at 08:18:32PM +0300, michael.nemanov@ti.com wrote:
> From: Michael Nemanov <Michael.Nemanov@ti.com>
> +		default:
> +			print_hex_dump(KERN_DEBUG, "message dump:",
> +				       DUMP_PREFIX_OFFSET, 16, 1,
> +				start_of_payload, buffer_length, false);
> +
> +			WARN(1, "Error processing device message @ offset %x",
> +			     (size_t)(buffer - start_of_payload));

I got the following error when compiling it:

	drivers/net/wireless/ti/cc33xx/main.c: In function ‘parse_control_message’:
	drivers/net/wireless/ti/cc33xx/main.c:798:33: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Wformat=]
	  798 |                         WARN(1, "Error processing device message @ offset %x",
	      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	  799 |                              (size_t)(buffer - start_of_payload));
	      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	      |                              |
	      |                              long unsigned int
	./include/asm-generic/bug.h:106:31: note: in definition of macro ‘__WARN_printf’
	  106 |                 __warn_printk(arg);                                     \
	      |                               ^~~
	drivers/net/wireless/ti/cc33xx/main.c:798:25: note: in expansion of macro ‘WARN’
	  798 |                         WARN(1, "Error processing device message @ offset %x",
	      |                         ^~~~
	drivers/net/wireless/ti/cc33xx/main.c:798:76: note: format string is defined here
	  798 |                         WARN(1, "Error processing device message @ offset %x",
	      |                                                                           ~^
	      |                                                                            |
	      |                                                                            unsigned int
	      |                                                                           %lx

