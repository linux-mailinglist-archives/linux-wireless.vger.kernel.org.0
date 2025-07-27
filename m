Return-Path: <linux-wireless+bounces-26032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B717B1304D
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Jul 2025 18:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54063B832B
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Jul 2025 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B721B9CF;
	Sun, 27 Jul 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMLZr7ia"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573937080D
	for <linux-wireless@vger.kernel.org>; Sun, 27 Jul 2025 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753632768; cv=none; b=aH1w87l/+F7/TTe8VF+qF8nVpX+mh2xQkwTHgeD2vuaTLWU2vWSDxQ7miE10UrSckTyA1xElAIfpNOFUGY5r10QTyJrB9yUTb1p2/mKlkxKMt2YPA8pqK/i6jtEgi4DRRrsS7nrD06v2SaRJPp4RxmEjNjmYPxBRq4I9V/HwM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753632768; c=relaxed/simple;
	bh=DFOzUj9K5sz2AyUXU0YQv0swbqE5NNAXVR7EWOuA31c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJN/pwo8Fm49TsVNhiYZY+mamfS/VMcMaPi9Uy5553k0Lx10+4x/T3ty9iWOKeFJe9fcR5CdmjBMb0hQNi8mHYwjJ4nR3VE5vi/0VQQTfvo1YRS5G6dopCpRJeBG5kBIUoe7und0/jbDe1LaAjIKZw4KSep7I5a7zAnwYa9OR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMLZr7ia; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso662553566b.0
        for <linux-wireless@vger.kernel.org>; Sun, 27 Jul 2025 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753632764; x=1754237564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DFOzUj9K5sz2AyUXU0YQv0swbqE5NNAXVR7EWOuA31c=;
        b=EMLZr7iacD8EDUHo8Ky55eWb6I8kNxiIQie2kmOE2Q3oKjMoOK9iqH+cJXTuNDa4EF
         6UgTkiUE5TPZ7SATI/Vp0UprkSgtiNW3B2EjE+nw7PLrEwLDDjaBloelmcCZxjBkh8Gj
         XV0G7w8FIns412oqInTWJ0YC6Z1kGIuguQ/Xc7RN96IurBfpHeIjY+ZqSmAnrQa5c9ro
         GtVspvT1DXuUdoLlQjR33di5/wDsPRucJbVa/a+C2YzVNXGIKtWM8x+xwTmu7SNO1+hA
         1rM0oKvhaszLGDMUv1ASRYZvoRAFO4QKlpM4yDm1Im46gvjR3KPn4YQVivLOa9f6P5R/
         /3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753632764; x=1754237564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFOzUj9K5sz2AyUXU0YQv0swbqE5NNAXVR7EWOuA31c=;
        b=S4bnqezZwwC4bDPr2WP12mdlSaPPk6rtyiEPHfsBuvaDASmUmZY7KnmsRC79zGpHkq
         /RzLVYzUfYBo1yZz8jVnMkHL+o4Tfker237T1ccJrGF7C14CrZ2qBxQhW+Ypn0/UJu2n
         fl8lsnEHFmWrxV60i20rJNn7HoT+kGpLMuTZ4CXsxdWzFIh1+k4HSalJ682J3d3zAjQu
         yR8I8ley6XO5AsVytbjerKpnabsfm9hb/dXRBxeQaEHz6j7oTwnHMpGhwwzX4beoE9H0
         2dKgBBIs0ZAuc4IiDQ634ckmQ6FFINoCrXR8H/g6pkuYKw6iL94KyiunJrrhf15jbydx
         ly4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaWXTQMSPVXnasp9v9VERtW0CPGcJMDy49Bu/E0zVWr9JTSenAZ+bhfxEdQzr5A4tWDRYYGFaBM4IQJlyGSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXf0el8vmSzoYlT+EXDkMyrYc6YNNIbkU1nGgZkx+JZNViwxbd
	tib8fkYbhher5e5tojEoFQiZ/DdLHvlJxawwiLTBCGDqw5woXgsLeffLMjCO7NNHS1Tnjp1PMzt
	0AI+ud+1xASeSPiVfzVm/x8VQqc0nqmE=
X-Gm-Gg: ASbGncvn85dZeJW3a1awgMqCAUkOzXw/tiQPJFI1tA0jxTQ8kLXNRPlF4QIt11o8uo2
	5RNnLxGcWTKhzGYniby3V9+NlqO1iFkjnypUgOqKy/9GRn5v08boG/BtK8GnUJm4dHmHJler00E
	QSuLU+sufoPPexNfCsS2GrKcaBkNKx6PuclnqgjqmWc2s7vp55RTcSWY5HRAVCb9sJxfUFXg8N8
	bA/Zg==
X-Google-Smtp-Source: AGHT+IGm5oJzXS1VTNxMFbpMraezq4mknIPV6KXIGvaUrUwahRYJxZJl9clULU2n4xwGWn/Ra+UYw+5hvCzryqbbQYc=
X-Received: by 2002:a17:907:9623:b0:ae3:c777:6e5e with SMTP id
 a640c23a62f3a-af61df52d26mr1030351566b.19.1753632764316; Sun, 27 Jul 2025
 09:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com> <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com> <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
 <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com> <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
 <979be2a9-9d0b-4382-8519-2f6fbcac5375@oss.qualcomm.com> <CAPDiVH9Fi3Rw4K4npHMAEcOPMj=iFMEJOyhn5cRaq3+9kBYNZA@mail.gmail.com>
In-Reply-To: <CAPDiVH9Fi3Rw4K4npHMAEcOPMj=iFMEJOyhn5cRaq3+9kBYNZA@mail.gmail.com>
From: Matt Mower <mowerm@gmail.com>
Date: Sun, 27 Jul 2025 09:12:32 -0700
X-Gm-Features: Ac12FXwBICgNG1gWDdZiWG0w1xg4GvfxWwSPgdsBoA9_Nhz0K07_JUa8-TYNFHU
Message-ID: <CAPDiVH_-=DzPjyjDo34-0HG20feiGfrM4eOpkPt6bavrw2qWaA@mail.gmail.com>
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	1107521@bugs.debian.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Baochen - aside from finding a commit where stability disappears (from
my last message, stability is achieved when I cherry pick "wifi:
ath12k: modify ath12k_mac_op_bss_info_changed() for MLO"), is there
any other debugging information I can provide? You mentioned that
firmware is a likely culprit; would it help to get a dump from the
ATH12K_COREDUMP feature (commit "wifi: ath12k: Add firmware coredump
collection support")? If so, could you give me a hint about how to
generate the dump and where to find it?

