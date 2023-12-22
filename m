Return-Path: <linux-wireless+bounces-1246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D981C8B8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 12:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60EA1C220CB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05590168AD;
	Fri, 22 Dec 2023 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsyJACmN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68804168A2
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso2140184e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 03:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703243095; x=1703847895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RWFs37rPcg3SdGckFZkM2dJltMbBwiXvVpRBpu6CRDQ=;
        b=QsyJACmNA7lwZ95lxd7GgQYYC9AbdFyMyPx1XOIKoPL7Z5zEBhQaz7oAp4jzmdOTuk
         Jzl6GWPkjbFk2fmwc1wsUb1NP1fUhMijXckT6CVz54qSI2F7HhsPVdyXtR5OqPVL02Ld
         QZSM3sQXQZrMchCtN608I6bc2P7hA9SHCEc9mkXMmD1rwaco4g+7YTDMDOmZFL17IG2x
         20qmkS+rNLZl1MYVlP24GKKFzlGqLl8xv0kGgZQgwaq2A48zCn7hkEOTgNRQXvHnAZkx
         hIPozWRnrNZ1l/71N1T+LZkF/t9RrgKZI5AGf/+I/hx9usnfqh/JeUWI678J/LJliLn8
         ugEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243095; x=1703847895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWFs37rPcg3SdGckFZkM2dJltMbBwiXvVpRBpu6CRDQ=;
        b=Ufp0MxYCX1/Dczx0KV8iUGm+4WHBk0odNQBCQCd2VoBNfPpZFrQeT6K8iUhevnxsm+
         ZrjR33YVykDSlmVgtat8Z1bFMmEtGh2H2iBeS2dHR6yi4hMs0JNvWUQrwvdKJ4Y1twZI
         mhVsj0ifivZEm2k+yl8u1BPMu0cCz8TPscLaiILmYY0gKAXggIXRS52OOPbwIMrHP28V
         RiqFOPLzPDqTyu/MNFdFK+5P2psXKNElvc0UW/aq9sh7SurFfke0zYPrJDiNKUqO3yGW
         C5qdGnt3u3okCKzchNhn/51Mv4g5DqZE3c+uhU6AkKy6g2sX22UKyHvkq0GIbjfVWDys
         bRUg==
X-Gm-Message-State: AOJu0YxDn53Xn+WKsDOXjjsbWLKcdaGETTCGdDMNetQ0w7abVfA78mmo
	yNTGIbSbwffx+k/213sAx4MOBYIVUmlpHO5bmqw=
X-Google-Smtp-Source: AGHT+IGd4knak6Qv156+z7D4pHM2F+YLnvcXepZOIzIibcR4ttN6Mou8Kc8U1VIrdlLP+P9gWuh2lga9f7+9X0EFFqQ=
X-Received: by 2002:a19:6547:0:b0:50e:3714:b420 with SMTP id
 c7-20020a196547000000b0050e3714b420mr547579lfj.9.1703243095032; Fri, 22 Dec
 2023 03:04:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMvbhF1GbgND_-h2yT=E5vgaatj6gUXJSt3tHo==TSeJOaj_w@mail.gmail.com>
In-Reply-To: <CAAMvbhF1GbgND_-h2yT=E5vgaatj6gUXJSt3tHo==TSeJOaj_w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 22 Dec 2023 12:04:18 +0100
Message-ID: <CA+icZUUregexic12dBTKeyd3hLpEXRv5SVtdUG4iqvRyCfc_OA@mail.gmail.com>
Subject: Re: Patch submission instructions
To: James Dutton <james.dutton@gmail.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:46=E2=80=AFAM James Dutton <james.dutton@gmail.c=
om> wrote:
>
> Hi,
>
> Where do I look for patch submission instructions for linux-wireless ?
> For example, which tree should I rebase them to etc.
>

Hi James,

check MAINTAINERS file for example:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAI=
NTAINERS#n111

says:

W: https://wireless.wiki.kernel.org/

and points to:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes


In General:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/submitting-patches.rst

Thanks.

Happy Xmas (if you celebrate it),
-sed@-

