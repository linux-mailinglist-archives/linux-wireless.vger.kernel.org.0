Return-Path: <linux-wireless+bounces-23577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E6BACCCBA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 20:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4EC16D871
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 18:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB6288C17;
	Tue,  3 Jun 2025 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="evnlob9Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C82288CA0
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974612; cv=none; b=XPE1fqglYzBiQLxb396LjuYBYscQi6BBlWCJErBe6agMmLGGmHEAA01vW1+toW1BCcy7yDA9QbNJvgXsuIKCIBq2mZrMCdyCcmzE5YmyD9+O3fP9RaL+CvWXACWpEGr3t42EIEHrKxRe/0vbOIKCQ2HizUqkvHtxykZim4ay4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974612; c=relaxed/simple;
	bh=XwZYNNYPEhCRT8H8UpMTHiRDWFFej+uLkqOYGvKnWqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqA21yFolj7aBcPMOl15rEgEMAmRdMWofQQo9tjPQR3wPVoyk0M5L4sb3XgBD4JzbrSsrhW8faW1sOQMEz5rn1QHBHNK5TKH873ewOcPcQYmyD8B0+h+/CzY1oH/NkslcDYZi7qsFKK+vI/WCrCNAx2EoQE8GsOU27IJNkDEHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=tometzki.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=evnlob9Z; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tometzki.de
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso5194469276.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1748974609; x=1749579409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwZYNNYPEhCRT8H8UpMTHiRDWFFej+uLkqOYGvKnWqc=;
        b=evnlob9ZzLNV28C1gxEo6ftwlN4sjSnk1SjzS2x+wUfx3A1i6+a7uSuhssvlZsSVnU
         otsyxwNsGZXlDVx3S2Vd0IG0tNdU4ZkL8Jv/cxt6y6jbfmxVFoonSCUveF0cZrqs0mV6
         CrsXnSjjp6gJ3S+Ok/jCAw64LV/tTkzkh4CnWg7TcT1jmDyma1ohRE5Pg2WG3ZapGG3Y
         Q31x7RjPYMHuBLHUgJegDRMbIyLD4zY4fPOrcdubX06tYSPqkyfUUqHt2F5zHAzaJaTS
         jQutileHkHkwFEVhL5wbhuMCy2tfDvXQe8iRonXGrfS5XOfF0kscQxTPVnip4KI2kXb6
         SQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748974609; x=1749579409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwZYNNYPEhCRT8H8UpMTHiRDWFFej+uLkqOYGvKnWqc=;
        b=P2WoR3yYf3PPABDNO75mVk9xECtLIWfIB+fZtKe2VY2mcKWM0fAc7vDLli2qiRLbeW
         EZQDvauzeUmjJwN9aw8QrhkOLVMUJ7G53LzvS0h2EMp9OPdQe20sieJQCHKX3irqDVzP
         RECBB1+cmc5EZ3URBcvkB/d4kaIlx4tfYcgH9HYytgTnU3y7f1lunG30EliCq+XA65+F
         mJLZKY+MDsg+BrCqqJseWG1i4EepjtaRLTHHpokyhMO9Dvt6h2b3xFn+CKdaJAc9JiP8
         4i6FrAg0J2iWwjiULJp5PxTc4lOx/qfhzYAbv9mlQzdhhOT7+LVy52ifN6azOXuE4vSP
         iqLA==
X-Gm-Message-State: AOJu0YzyTbxA6E2ZEhbpz992X9p5EjCNMxrtgcJ8XVeJ6rBldyIATbFV
	7kJEmnvVVPCZgxt0/7wjLJ2cVp/TNZIy06oWHhMGvP7PaAfqcpjLHZfhQ2PASzqwZfnTzx/i+0r
	YgPYsL9Zfg3BwkPyZ0CZNMnM/2ib+RCO9mzTbagqVmC/aAhY68p7geJBHLQ==
X-Gm-Gg: ASbGncvhowclU5IgDpBo53M8wyDjFnTJmIqmFWtT7qFTSH7Wkxy+mm+Fu47kHBW5ESa
	6KWxZIbg92Zj2W9IfDjMm44AIeIzFsyfIup/s/E3DmckFyib1B8a7G16Dqu3CHvWweXgP3tf2Ez
	iGymM9M3jJ+o2mfvFfmujCnhv+15G++4n6NUo5ucVFilK+mO3uQl0cC9SVli7W6euJ4wryD6k5w
	Bo=
X-Google-Smtp-Source: AGHT+IFBIpNs5ZFdnmrMyOSBi+WesTkbjtEja3Fo1Yjt1PD6fJ9G9DUcF4K51Sm5nZUrijd5LAIIjQgaZFbzpSu/HG8=
X-Received: by 2002:a05:690c:6107:b0:70a:2675:70b3 with SMTP id
 00721157ae682-71057cf83e4mr246755997b3.17.1748974609387; Tue, 03 Jun 2025
 11:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0107019736e3a599-79e58a4a-0dfa-4f43-aeaf-4a4208845b32-000000@eu-central-1.amazonses.com>
 <DM3PPF63A6024A98E210FB9D166A3CD1316A36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A98E210FB9D166A3CD1316A36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Damian Tometzki <damian@riscv-rocks.de>
Date: Tue, 3 Jun 2025 20:16:38 +0200
X-Gm-Features: AX0GCFuLbmz7320MGfValmAaRgWc694_-_RyvStDPr9rmaaBAYCOu-qNr0PlmX0
Message-ID: <CAL=B37=-q=Veghr7bo2GGiy1eyKP_xF0g8SeK5Lu6uKTVZgxoQ@mail.gmail.com>
Subject: Re: [wireless] WARNING in iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miri,
If you need a kernel trace, I can provide a trace-cmd log. Please
confirm which events are relevant ?
My idee ?
sudo trace-cmd record -e mac80211 -e cfg80211

I will reproduce the issue and attach the resulting trace.dat file.

Regarding suspend/resume:
- The warning appears after resuming from suspend-to-RAM.
Please let me know if you need further details or a specific test scenario.

Best regards,
Damian

On Tue, Jun 3, 2025 at 7:50=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Could you please provide a trace-cmd?
> Does this happen also before suspend?
>
> Miri

