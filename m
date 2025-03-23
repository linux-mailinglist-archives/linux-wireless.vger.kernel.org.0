Return-Path: <linux-wireless+bounces-20719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8D8A6D291
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 01:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CAF3A8A05
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 00:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9556AA7;
	Mon, 24 Mar 2025 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aegrel.ee header.i=@aegrel.ee header.b="crarqOZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from aegrel.ee (mail.aegrel.ee [51.195.117.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE01FDD
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.195.117.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742776191; cv=none; b=krcEFDKROvWjqzSVYZyTQFqGLug3slS1106cJYApB11oCDaHs+2/AUmblnsndGbdUN80PW4CB/LKJJCUxmTdKKQbl2U1hpgAnTvpYPYrEEiBkis3eiIf2S9nyyzhOVnAWiPiEidMAJrHygczJtjz+I+XTEJJ4FibfAsq2AcQUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742776191; c=relaxed/simple;
	bh=XQZy5fcF6RvFZ3iU3YsO2JmW4uOxF4U2Mh2QChAVSpA=;
	h=From:Date:Message-ID:MIME-Version:To:Cc:Cc:Subject:Content-Type;
	b=BO1lZTHp7vep7A5CXnnR73LZW4zYGDmdtlWS0kFrIkfEIwP5sE5znXBPKviWxJM3BmnkEDUw1KzlA1etq0YxwNSa3bTL2wNx1W96+V8ZalbGPL+arJUaX8R14NZCCEuRgPJ1UBG4tpYw6t9Vm2nsOMQfGAU27JEVKglR1V2jJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aegrel.ee; spf=pass smtp.mailfrom=aegrel.ee; dkim=permerror (0-bit key) header.d=aegrel.ee header.i=@aegrel.ee header.b=crarqOZK; arc=none smtp.client-ip=51.195.117.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aegrel.ee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegrel.ee
DKIM-Signature: v=1; a=ed25519-sha256; s=default; d=aegrel.ee; c=relaxed/relaxed; r=y;
	h=Content-Type:Subject:Content-Language:To:User-Agent:MIME-Version
	:Message-ID:Date:From:Sender:Expires:Content-Type; t=1742776187;
	x=1745368187; bh=XQZy5fcF6RvFZ3iU3YsO2JmW4uOxF4U2Mh2QChAVSpA=; b=crarqOZKiN
	TgvG4Qui3wWQhdADNqmst0tvXK6URTleN/VAdqLLDg3yMB9eLR/jGyyyv3k0q94csiNAWlGQUSD
	w==;
From: =?UTF-8?Q?Taavi_Eom=C3=A4e?= <taaviw@aegrel.ee>
Date: Mon, 24 Mar 2025 01:55:05 +0200
Message-ID: <c6eb2f23-f15a-4a4f-9934-f8d524bc2cd1@aegrel.ee>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen-Yu Tsai <wens@kernel.org>
Cc: wireless-regdb <wireless-regdb@lists.infradead.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Subject: [PATCH] wireless-regdb: Update regulatory info for Estonia (EE) for 2024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

QWxsb3cgUzFHIG9wZXJhdGlvbiBiYXNlZCBvbiBjdXJyZW50bHkgYXBwbGljYWJsZSB1c2FnZSBydWxlcyBzcGVjaWZpZWQKaW4gYW5uZXggNiBvZiAiUmFhZGlvc2FnZWR1c3RlIGthc3V0YW1pc2UgdGluZ2ltdXNlZCBqYSB0ZWhuaWxpc2VkIG7DtXVkZWQgCnNhZ2VkdXNsb2FzdCB2YWJhc3RhdHVkIHJhYWRpb3NlYWRtZXRlbGUiIAogCkVuYWJsZSBBVVRPLUJXIGZvciBhbGwgNUdIeiBiYW5kcyBhcyBubyBiYW5kd2lkdGggbGltaXQgaXMgc3BlY2lmaWVkIGZvcgp0aGVzZSBiYW5kcy4KClNwZWNpZnkgNkdIeiBwb3dlciBsaW1pdCBpbiBtVyB0byBtYXRjaCBvdGhlcnMuCgpGaXggNjBHSHogYmFuZCB0byBtYXRjaCByZWd1bGF0aW9uIGFuZCBhbGxvdyBiYW5kd2lkdGhzIHNwZWNpZmllZCBieSA4MDIuMTFheS4KCi0tLQogZGIudHh0IHwgMTEgKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZGIudHh0IGIvZGIudHh0CmluZGV4IGUzMzFkNGYuLjgzZjc5MjQgMTAwNjQ0Ci0tLSBhL2RiLnR4dAorKysgYi9kYi50eHQKQEAgLTYxOCwxOCArNjE4LDIxIEBAIGNvdW50cnkgRUM6IERGUy1GQ0MKICMgIEVVIGRlY2lzaW9uIDIwMjEvMTA2Ny9FQzogaHR0cHM6Ly9ldXItbGV4LmV1cm9wYS5ldS9sZWdhbC1jb250ZW50L0VOL1RYVC9QREYvP3VyaT1DRUxFWDozMjAyMUQxMDY3JmZyb209RU4KICMgSGFybW9uaXplZCBDRVBUIGNvdW
 50cmllcyAoSnVseSAyMDE5KTogaHR0cHM6Ly93d3cuZWNvZG9jZGIuZGsvZG93bmxvYWQvMjVjNDE3NzktY2Q2ZS9SZWM3MDAzZS5wZGYKICMgRUU6IGh0dHBzOi8vd3d3LnR0amEuZWUvZXQvZXR0ZXZvdHRlbGUtb3JnYW5pc2F0c2lvb25pbGUvc2lkZXRlZW51c2VkL3JhYWRpb3NlYWRtZWQvd2lmaS1zZWFkZQorIyBFRTogaHR0cHM6Ly93d3cucmlpZ2l0ZWF0YWphLmVlL2FrdC8xMTcwNTIwMjQwMTg/bGVpYUtlaHRpdiAoTGlzYSA2KQogIyBFRTogaHR0cHM6Ly93d3cuaXR1LmludC9JVFUtRC9zdHVkeV9ncm91cHMvU0dQXzE5OTgtMjAwMi9KR1JFUzA5L3BkZi9lc3RvbmlhLnBkZgogY291bnRyeSBFRTogREZTLUVUU0kKKwkoODYzIC0gODY4IEAgMSksICgyNSBtVykKKwkoOTE1LjggLSA5MTkuNCBAIDEpLCAoMjUgbVcpCiAJKDI0MDAgLSAyNDgzLjUgQCA0MCksICgxMDAgbVcpCiAJKDUxNTAgLSA1MjUwIEAgODApLCAoMjAwIG1XKSwgTk8tT1VURE9PUiwgQVVUTy1CVywgd21tcnVsZT1FVFNJCiAJKDUyNTAgLSA1MzUwIEAgODApLCAoMTAwIG1XKSwgTk8tT1VURE9PUiwgREZTLCBBVVRPLUJXLCB3bW1ydWxlPUVUU0kKLQkoNTQ3MCAtIDU3MjUgQCAxNjApLCAoNTAwIG1XKSwgREZTLCB3bW1ydWxlPUVUU0kKKwkoNTQ3MCAtIDU3MjUgQCAxNjApLCAoNTAwIG1XKSwgREZTLCBBVVRPLUJXLCB3bW1ydWxlPUVUU0kKIAkjIHNob3J0IHJhbmdlIGRldmljZXMgKEVUU0kgRU4gMzAwIDQ0MC0xKQotCSg1NzI1IC0
 gNTg3NSBAIDgwKSwgKDI1IG1XKQorCSg1NzI1IC0gNTg3NSBAIDgwKSwgKDI1IG1XKSwgQVVUTy1CVwogCSMgNiBHSHogYmFuZAotCSg1OTQ1IC0gNjQyNSBAIDMyMCksICgyMyksIE5PLU9VVERPT1IsIHdtbXJ1bGU9RVRTSQorCSg1OTQ1IC0gNjQyNSBAIDMyMCksICgyMDAgbVcpLCBOTy1PVVRET09SLCB3bW1ydWxlPUVUU0kKIAkjIDYwIEdIeiBiYW5kIGNoYW5uZWxzIDEtNCAoRVRTSSBFTiAzMDIgNTY3KQotCSg1NzAwMCAtIDY2MDAwIEAgMjE2MCksICg0MCkKKwkoNTcwMDAgLSA3MTAwMCBAIDg2NDApLCAoNDApCiAKICMgaHR0cHM6Ly93d3cudHJhLmdvdi5lZy93cC1jb250ZW50L3VwbG9hZHMvMjAyMi8wMy9FR1ktTlRSQS1NYXJjaC0yMDIyLVNSRF9FbmdsaXNoX0ZpbmFsLnBkZgogY291bnRyeSBFRzogREZTLUVUU0kKLS0gCjIuNDUuMgoK


