Return-Path: <linux-wireless+bounces-4343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B22870861
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 18:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43C9B23DC6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4ED6026F;
	Mon,  4 Mar 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbUvT6xe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0A45942
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573803; cv=none; b=EPa3KvYbFNMJvdKKXpJ+tOUSSQGIWkMY0HPgqveeKLhent8a4OSvh3hKi5zcNs2Mbl/0y8FRFkcHASm7pBRyOPXkweUC35Ti6dJk3RqSaxCzjAl3hFs3Y9CB7UqBHPnHeoNuSrauUGCzMwdbxLHTm22EtpjricwhBdAHJ7D8t1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573803; c=relaxed/simple;
	bh=x0cxzbpjoyvdXqMNr27LADNQou95xpV813xwiZn5Wb0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GUwfojGJwmLOMArGKybxWxZUeVktTzSwwOvdLWL9I2i2tr9HLToy1LHpDoFRqFeF71lJ+eniX4ZTcKD1aec1PPCqh/9ozRAyYaMWFFOJ0RcMU3Kn+tFHU288Kqu5BI85th+RWblYy+XTxxrtSuMw1Rt+u4pb5aR5rdyOpKO3ARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbUvT6xe; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21f70f72fb5so3559858fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 Mar 2024 09:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709573799; x=1710178599; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0cxzbpjoyvdXqMNr27LADNQou95xpV813xwiZn5Wb0=;
        b=QbUvT6xe+TYewRUGHUZy1rSmYh53D6uJ4ddC2OdEYzO10BG+E27qkTTIq+YI0zGpFQ
         UDJQ9wGx3S9DbVuy6QIifdN3SF4Ge3I/jWJWv4Z4Z111CZYPjej0fciyHcmqH0QlHF2u
         1CmyC0di3B7heXDPiPtbkTB5Y4gs2xb2jlLHV8pL/pLPEGUqqRJNHR9ZriZSZoWtfUOa
         8wuG6ks6hkQWMuACFdub4smXjEbLeWcxJS0dojXwJV0YfmaBBnrbGbt6FD545iqPUIdT
         lvIWBhyutMsvf9ieaRPmgW97fWG1W0AeeX3i9nbLtzik8Uibhze9pBpBhbbR4R6m7xTf
         n/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573799; x=1710178599;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0cxzbpjoyvdXqMNr27LADNQou95xpV813xwiZn5Wb0=;
        b=ucYm5ubqotE/OR491gRB8a3WBRrof3JK6cd/e9MgyYg0x6WBeP8Eu/BDpfWPzrm2Fd
         oIZxkHJVrfFWktY8XGvwlsZr5x3519XxJKWMxdDP+ZivBiU7SMgrS1jLQQg0josIHWss
         khQ6f4enr/EOk4ROfCrhjU5bN1DtEy+ma0U6+EBo2RaAOTZe8tQSaGEDSS49zwHIfdwY
         o7l4XnLuAtAKyeJQiqTFZ/JQLwTFE/EUrdFy+9DoEwy+C24SdgqB3f5rpGa+hMl7eQu0
         e9aS4m+mVHB3UMARp+Bw5YeGxHoML87FMyd9+MxEHnZhV6scqfE+PdChwgs2yCSthrzK
         gN/Q==
X-Gm-Message-State: AOJu0YxbNTEnIv/4cYlEFvuS2TxOCTMz/yBX5NRM1jSSj22ps0+h47+B
	n5iArkam38CVgPZXN1ILELKZVHCmIGL9UVHjooyeZ6Q4K5m74ppiGihd8kP3bk5I+ZhqNeuWene
	3QPPNbnGSbSnyMfrcMQoc6LTFSmzF159Vs6c=
X-Google-Smtp-Source: AGHT+IHvvq6FwFsc6cFQX92GS4uHlNXHVs5KuZ6P1FZ7YoAsc6jjR6KJAuUoVqaukAs23pZu9VMMKbaVfDs+ICMr0+g=
X-Received: by 2002:a05:6870:7248:b0:21e:aca4:883 with SMTP id
 y8-20020a056870724800b0021eaca40883mr12429626oaf.15.1709573799635; Mon, 04
 Mar 2024 09:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dead Ballo <deadballo@gmail.com>
Date: Mon, 4 Mar 2024 10:36:27 -0700
Message-ID: <CANJ9ypXpS8M57B+N8r8NvH-jA9uBpHAf7Afp4hfLCqV7sBJL4A@mail.gmail.com>
Subject: How do I limit ath9k wireless interface to 2M?
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello. I need to limit a wifi adapter to using 1M to 2M because this
and another chipset (rtl8187l) have better reception fidelity at those
bitrates which is important when creating a mile-long link. I have
used this successfully for years using an older kernel using the
argument:

iwconfig wlan0 rate 2M auto

However a solution using the new method using iw wlan0 set bitrates
has evaded me. I have tried various incantations which don't seem to
work even when they go through without error. Firstly, nothing works
unless I reset the interface:

> ifconfig wlan0 down;iwconfig wlan0 mode Managed;ifconfig wlan0 up

Then I *quickly* have to set the bit rate. Interestingly, the old
iwconfic line above also executed without error, although it doesn't
seem to do what is intended. Anyway I'll enter a line like:

> iw wlan0 set bitrates legacy-2.4 1 ht-mcs-2.4 0

or
> iw wlan0 set bitrates legacy-2.4 1 2 ht-mcs-2.4 0 1 2
(or iw dev, not sure what the difference is)

and again, it will enter without issue but the bitrate does not get
constrained. If I try to enter ANY of the above lines (including the
iwconfig one) some time after a connection is established, I get the
command failed: Invalid argument (-22) error. Same exact command,
syntax, and options but this time I get an error. To get around the
error I have to take down the interface and put it back up, although
again I don't get the expected behavior.

Any help would be appreciated! Unfortunately, I can't use the decade
old Linux kernel, which worked as intended, as backporting everything
else would be just about impossible.

-Ball

