Return-Path: <linux-wireless+bounces-23579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA229ACCCEC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 20:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D687A35A3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35737288CB3;
	Tue,  3 Jun 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="NZYs77jj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03846288CA3
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975272; cv=none; b=NPs8C0hLZNwklGjrKZBHLfwbXlxejDnS/4SfDkMbTyTLXBrnYU2nCG34GTfig/kPRX+xo0N7e2+i0pwHhgrV251p/htE6Nlj88Rtuz6GAwPRjF+TOOfMJ81RWsSTi2+NdhP7owXjF4pDDm812Y09+d/kmDcf0c6hcHyEOS/GyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975272; c=relaxed/simple;
	bh=iGeXfLl7IWjLNNVm59Z7FuRkNW0L3x382uxZjTlgwJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsuMbIcL+1P3Rb2jASwIQ4qN/tuRERXVn30wTLmXrURNXIHsefxDHIguTH6nTdNLC3K6lxX3sm8yf2VBeopC4u9EAaJcuxS232bUbzw2+IT4/2N+TWWqpFrZ2mLf1IuItMut8+xUAx4zKTe4sAz80sbXmt6RL78Lajuc+omQvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=tometzki.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=NZYs77jj; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tometzki.de
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso3964635e0c.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1748975269; x=1749580069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F84xp5anr9EIAmscjiL0kEmCw2MqV+hSPCs19dt7n58=;
        b=NZYs77jjFGa0tjkcMjzVodcG/hjvGbWOHyitf4m9SGiyVsB+Ms5fK+EKug0pFqsxEL
         bk1hBB8nr3jd3JLw65xSINNFO6qeI+sP4UCY4DalHA4nStkK1oEqh6oLDAo8baO1oqQw
         xIB4z2AbuICaGWFLMSEfAxiy4SqvPW1Yxs9Y1i4qSb62xcnyKUqooAnh3swT58NBbaJX
         tXHG52cBXfiPWO2OFp7de4lC7G1cZN6z4NZ6upGBLBBB+CfWcF6g8+HXGHVNJvagRZ/s
         NRNipRnXncKO0oH22Rp69tYFvkO9m5h1rJpqERy5pbIbtFiAU8VKXcxZxN3woS2feZni
         ufLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975269; x=1749580069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F84xp5anr9EIAmscjiL0kEmCw2MqV+hSPCs19dt7n58=;
        b=rSUew8Bdk3ntvYITHcoQSXZ3wLrpBRISwt0bo42hPKf9x2M5cZUxhQcXZcBVbrA+JS
         NMgTSfWJTevEkW5u06QQ/C+0+prqYswe1Kl6GKav49CBTZ3rtC+1tWmSzIr2bByppcKU
         f20k/ah2Ln86AxYPGrBWnb1ZF4aDIvjykGHe1aCTvPHlxOyLmukFh3u2KynDCSCuP1XX
         PA5KtedWKtlg0EYcxQYU9QPt+emV2e372LIgzxlhyU8JoqKiyEnZ1WkfJuH+3yARF+0P
         JeIcEUG36oNuDuxyVDFovP9pMdWgNFN8UCGfGT86uK4OUuK0A5/qXB/hO3fyyzKyGUBI
         AVdA==
X-Gm-Message-State: AOJu0YzUV51PBxwVwKCFc22cIf5xS5RTEL2xCfMmqfe78DbdXOcuQT19
	2fsbb43SF65dZYgjubsfYcBgddyaU+3QgeMAgQSECRSCfghilZ0xCe55oN/PWq7caAg00aC75RT
	t4eTNUDhtLplRSKyJixk3jY93F4mkOQOS0LNDD9k8Ew==
X-Gm-Gg: ASbGncs6NEwa2gZlwaiSw4rMJdvphU6Vg4D1S43OZOFsErLYKiLFWX/jRLENfaOUo7L
	8wiIvi0dYsHSRMwaJZMHjVzT4EFoj/I4NtQ+yv8nsRN6jY6H1m9gu6nE2zsn2dZRLa5djMTRrlN
	oBbI3tHAQrH0UwYqOWlv8oHifO7bYaorasJdX7WGQXDvyan5OBZHvDrXD5KnZ5/TjROuDz9j+H7
	Vo=
X-Google-Smtp-Source: AGHT+IFv8GHk0B9iWYVCI5VP7cxO969puIxjjsFGSnK2bTrRJmgjBMCCrvl+7lxurp59nHqxat5XTMnZs2jJfWTVEQ8=
X-Received: by 2002:a05:6122:a20:b0:523:e2bd:b937 with SMTP id
 71dfb90a1353d-530c7228a4bmr21638e0c.3.1748975268814; Tue, 03 Jun 2025
 11:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0107019736e3a599-79e58a4a-0dfa-4f43-aeaf-4a4208845b32-000000@eu-central-1.amazonses.com>
 <DM3PPF63A6024A98E210FB9D166A3CD1316A36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAL=B37=-q=Veghr7bo2GGiy1eyKP_xF0g8SeK5Lu6uKTVZgxoQ@mail.gmail.com> <DM3PPF63A6024A97BAB8D43C0FAEB7078BCA36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A97BAB8D43C0FAEB7078BCA36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Damian Tometzki <damian@riscv-rocks.de>
Date: Tue, 3 Jun 2025 20:27:37 +0200
X-Gm-Features: AX0GCFuB4_rQMwEL07mw7f3u5FtJK_CUHLQmdUhe4u0U3JD39iRyYmLxlHpgGoc
Message-ID: <CAL=B37mvp3jfTbsg1DjEMxv5UU-sg27N+vkuUY5059yrzTQz0w@mail.gmail.com>
Subject: Re: [wireless] WARNING in iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:22=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> > If you need a kernel trace, I can provide a trace-cmd log. Please confi=
rm which
> > events are relevant ?
> > My idee ?
> > sudo trace-cmd record -e mac80211 -e cfg80211
>
> trace-cmd record  -T -e cfg80211 -e mac80211 -e iwlwifi_ucode  -e iwlwifi=
 -e console -e iwlwifi_msg -e mac80211_msg
>
Hi
the most events in the trace-com doesnt exist. Need something to add
into the kernel config ?

Damian

