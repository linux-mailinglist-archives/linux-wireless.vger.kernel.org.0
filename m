Return-Path: <linux-wireless+bounces-12775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A82F974451
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 22:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116511F2596A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2661AB501;
	Tue, 10 Sep 2024 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnUUVqWE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA11AAE15
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001359; cv=none; b=IJlw1U/KFcBUzhSzeRByYlVq4n7GPjxl6w+deBE5fRF5MIlKa99w6MyZ7+A6rLbjkGcUXzvDn6myO9jprmQfGHY2RLMwkvwD3eLf0Lj6mp+6BHjDSIJrtWKNpv8Qqv0qAcVgzm4f9jbok/74KVCLjtc7aGcYjyWLiPlpbwiuj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001359; c=relaxed/simple;
	bh=ZorfYCkwdwEBbCGQLTXlj12nKqHDGDGFhx+qtIA9AVI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Fdj9grJbFI13NpZSki7BoXr8xZPfUh622VpYDIMUhEI+7rHUZ6cPVDBj5COX+PS4QE5TeATEFlrFI0SUM5wpoikN5ppFfotE4bOVTvFBlQsnOC/OxdJEunjOos8y5aZb5z9My/iJprXdWaM/5aG0W+M8GeIN2ThCKShCGERVw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnUUVqWE; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a80979028so6104033276.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726001357; x=1726606157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZorfYCkwdwEBbCGQLTXlj12nKqHDGDGFhx+qtIA9AVI=;
        b=gnUUVqWE4KBAXzrw8SZe+2BI9xX6SpPoM8kH7k7cz986sVYTTfqYbidSI7wJcLPuQp
         Gp1Qu4jCrTrbeXY9eMkHFTGWH1iQ+c82/7JHsxB1Tc03lOazIOxLzM27Y6SCNjtJbV1O
         WBHTXHbdRY1VIGams6t9jNc88MQtvxVE/TiDiAcsf5TehW6Nuq3Y6iI8AeHSi/q3l0Ok
         Nk/rNtRDtNBCgQUiYJ5Lptne0BXiCNQB10VMXjkoybhoiAmq4GKVwDkP5c01AVVZn6Iw
         5hvdDQ3A19jRbf3csMFI936zzMeyYeoRt+TeN40Pqd34aqhMWxuQLv4VZqnK+yBNAR16
         nDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726001357; x=1726606157;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZorfYCkwdwEBbCGQLTXlj12nKqHDGDGFhx+qtIA9AVI=;
        b=Y1GWLiEY652v5PowBLZ0sTVpDYINvx18sRPza6QKJmbPxTew8vJfoVSlwYLoEpQr38
         +/ripkZeq9lFwf9hHpevEwl7PodEwatuHcXWhxCO7guzpbRVGV5bop4lTHavt8HD/0B1
         y6QC8FSbXjce0np7l/UPr+V11YXALaPJtFxqBIqrI1LBSn53Ijtob6B8dWyRKOs2WTnV
         IUSj6OQDnBBikPGCLkLNRbQLrCLKjqArsKbfI5NEqtIk50GHxLseVDI/MlxUiKRMXRXj
         +X7sTq6WlzJbmywyo3JjP+rejZyA3FwAHqH+uOa/gV95rTCnO8z1cVRq8FEIYiwABUJc
         9Dbw==
X-Gm-Message-State: AOJu0YxwgJUPM9FjoPhwWgow3lAnyLR02vZLRsKtE11mYdU+fAmPNqs9
	Umf2lncBEEAjagPRopAZfWslt3YnkKpX50CGF4Wbq8eiaSziWGZ/kxkyqKskEv0jluxJyQjPhGG
	J9UAfBAAHf+/3t5JsOAbXRoDVlvanC9GD
X-Google-Smtp-Source: AGHT+IFQaydbTcq7MgsPG9jJoqbvX30T6urVZ2vL35Bz0+r8g9Hi6uBKulgUdzvheeTCZQJGYGcWO0JqY1YhCUHlkFc=
X-Received: by 2002:a05:6902:10cd:b0:e1d:2fce:1618 with SMTP id
 3f1490d57ef6-e1d34882074mr13827402276.13.1726001356602; Tue, 10 Sep 2024
 13:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zulkifli Izoel <izoel21@gmail.com>
Date: Wed, 11 Sep 2024 03:48:39 +0700
Message-ID: <CAKAWfyLVNrCzYoACGt2zAJ5K5FnBJkDmHuVAfmScQ3=_ahSEbw@mail.gmail.com>
Subject: wireless-regdb: Update regulatory rules for Indonesia (ID)
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

country ID: DFS-JP
# ref: https://jdih.kominfo.go.id/produk_hukum/view/id/862/t/peraturan+menteri+komunikasi+dan+informatika+nomor+2+tahun+2023
(2400 - 2483.5 @ 40), (500 mW), NO-OUTDOOR
(2400 - 2483.5 @ 20), (4 W)
(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR
(5250 - 5350 @ 80), (200 mW), NO-OUTDOOR
(5150 - 5350 @ 160), (200 mW), NO-OUTDOOR
(5725 - 5825 @ 80), (200 mW), NO-OUTDOOR
(5725 - 5825 @ 20), (4 W)
(57000 - 64000 @ 2160), (10 W), NO-OUTDOOR

