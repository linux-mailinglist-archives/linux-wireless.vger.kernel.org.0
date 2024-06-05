Return-Path: <linux-wireless+bounces-8587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A98FD6CF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 21:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520971C223FD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 19:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6CB15443B;
	Wed,  5 Jun 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtZ2mA7N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21F154BF9;
	Wed,  5 Jun 2024 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617268; cv=none; b=Goorn1uogyzibXYRNNH2l63AvyxPYqAcrFCUP9P68neJAa1F8UCywTUMiBVUVMo6IHBtkp9pRQAT6fN2vNNg6Qb3gAebnJ1RzxV8joi7Ku+Bl97GpYNiAoG3tK17M59pNchJ/5ckylswBrZYSp7NXcVL2xmhGw7FyOHNFSxwU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617268; c=relaxed/simple;
	bh=+MY40fely0yAhyFPkPlHk3xRM27wG8udewadRMc4KeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIFFmc2ZtzNkx/IxHwGt+ay1x5pIjDJ2ywS3kli2hwjBS1KBEJ6AuSnDciMsnuaa+7sg9kwpRlhQ3Cz7tVdQx/oj7E0GLiElIwWJzFHRqto6442t3sDIiYaHZ8jJLKyHV+nOSZEmFFGp6oEsL98++wymY+NlJ2g7D8JDzg5Ga4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtZ2mA7N; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f945b242easo142370a34.1;
        Wed, 05 Jun 2024 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717617266; x=1718222066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MYWFYC0miA5hqdy7YN8GRMQMxM9HNoPBybSxK4N6ayM=;
        b=MtZ2mA7NrOY1G14DYn2uLH0FUNINE1EAukuVEJ0Mi6T24TyRoDK6RlFl99S8ox+iO5
         C3PWsr/6OAdTNcNf8obCcIvycTPddzGW9VNOoyDf0f9rgjaaH8sUeCs785brY0MMN0fl
         wyf4NJh6UsyNoAwnmbjXdqXwotdwPFueYzl73pqlBJSUT6bguX4xE+u07SEVM4pA4SxJ
         sj5pu5wZTVoihenP+1+hH0sbxHCuHDsrgcNKRTZezgNIWYkoO9UcBXUSHO0UZp1h2HlT
         bZ8YvT62ytClbUE7TQOQxMUopN4ORg9D8ngpq3JGDNTRmzkSHNpnco6cZACn3EzlWASj
         VKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617266; x=1718222066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYWFYC0miA5hqdy7YN8GRMQMxM9HNoPBybSxK4N6ayM=;
        b=c7/rDbIao01Z+6w3l6jW2QR1yDYGDY6dqhXkxYhn8FGxQ9ShsQ1zZFXdbJ40k7VBC4
         u8G7djzjxJ6kDxF8J5Smzv+O5+dvWfIiUpZlJfrTAGP6L6vbg39fZHvt8HF0D+hjfbz9
         5VvMwIbPKigUy0GvtIeNSYxP0j8RQ9HTHWZOHlLAlrNC3zKi/zFIom/v03/v9tUrjbh3
         jKIUdahJ+7+VCsrq8nf5lJA/7ufQH3VM2ykhC1VjCZBw2+xZZwunXanaoZs7XJlfxgWo
         8EAk5rkspz9QJITFRvybQE5EF4/pC9pJQBkgEV4Gmy0wtGj6m1wPWm67UNrw8lHx2Uay
         7ULw==
X-Forwarded-Encrypted: i=1; AJvYcCWJsd8cbARMePo8MOw1fNAMUS3DQCuobil7e9YX8kiWSqcPoJH47Fs98Wm2a0Inc1t0TWgo2cfJXEo9sgnn3A3DyC7YN0kYzGD3talY3zcAE+RWjE/TIVju0VGTGhT6jZ9MvTM+HyZ3MG5cqno=
X-Gm-Message-State: AOJu0YxPXyE4172z6yhfAoLkzm9UNcPrboCbCkLhu8gGjdUD4kEUrCgA
	LNctuSee8VOI3cWh8AROyheDx8GA8P/U6ZtQhQ7PcyQiCCuEjtoxcYkVoAJSxSCsSsVykngEOVt
	0QrWzS+iiJ4xc4+GAhoMxcAVYk5M=
X-Google-Smtp-Source: AGHT+IG8KVqezO2d9AlJKJ9+MvNqiT51WUXLrY2RAu5hGE9PLzTD/XaDxitQJBjkpgONT1t3LSYRsE6W/sMcn2a5taY=
X-Received: by 2002:a05:6830:1542:b0:6f9:3775:73ba with SMTP id
 46e09a7af769-6f9436b5d3fmr3661648a34.28.1717617265908; Wed, 05 Jun 2024
 12:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605183710.66016-1-trintaeoitogc@gmail.com> <00555ae56b4193f47d32550440829d1c542534f6.camel@sipsolutions.net>
In-Reply-To: <00555ae56b4193f47d32550440829d1c542534f6.camel@sipsolutions.net>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Wed, 5 Jun 2024 16:53:49 -0300
Message-ID: <CAM_RzfYMzHpL7Z+3mRN8P0shJX6mQ+hecHXdydszZnO6eAFAbQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] iwlwifi: mvm: adding check if the thermal
 firmware is running
To: Johannes Berg <johannes@sipsolutions.net>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org, dmantipov@yandex.ru, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

 Johannes Berg <johannes@sipsolutions.net> write:
>
> On Wed, 2024-06-05 at 15:37 -0300, Guilherme Giacomo Simoes wrote:
> > In the dmesg is showing the message "failed to read out thermal zone"
> > as if the temperature read is failed by don't find the thermal zone.
> >
> > After researching and debugging, I see that this specific error is
> > occurrenced because the thermal try read the temperature when is started,
> > but the firmware is not running yet.
> >
> > For more legibiliti i change the tt.c for return EAGAIN when this was occurrence.
> > After this change, in my computer I compile and install kernel in /boot
> > and in my dmesg the message "failed to read out thermal zone" is not show
> > any more.
> >
> > I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> and
> > Kalle Valo <kvalo@kernel.org> for your suggestions in my first patch.
> >
> > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > index 8083c4b2ab6b..68ab9966330c 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > @@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
> >
> >       mutex_lock(&mvm->mutex);
> >
> > -     if (!iwl_mvm_firmware_running(mvm) ||
> > -         mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
> > +     const int res = iwl_mvm_firmware_running(mvm);
>
> const is useless, but you should not have variable declarations in the
> middle of the function (per kernel convention)
>
> johannes
>

I really appreciate your suggestions. I sended a new v3 patch without
the "const" keyword.

