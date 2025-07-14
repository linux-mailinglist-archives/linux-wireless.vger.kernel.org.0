Return-Path: <linux-wireless+bounces-25386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D50B03FBD
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 15:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D85D4A4E6D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28FC2528E1;
	Mon, 14 Jul 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.in header.i=@nic.in header.b="U9E969Ic"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vastu153.nic.in (vastu153.nic.in [164.100.2.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8124C07F
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.100.2.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499223; cv=none; b=Gtc3STy+jTXtzphIUY00D6DbBLuwbmKoBApWb5WcMGF+OGroKkDqO5nm5GmsDd8Q3QlQIvcb4M4p8f2YiQ9Xuln+uFfDuVr40WZwbGkXC2/mfuWM8PKKtxnRHexA65wzCFa7L3I7MCHyo3eIZBBEr5oC3kIOnlAFu3+kEJjGGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499223; c=relaxed/simple;
	bh=XO7Ib6cNjLBYafu+OY0GV6AScAnMGno5ATOomZu0n9s=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=BnHGrn8pcEebbKXPabFix6uH3wulg/eVBBGLJDUjuhsZglOPfeU3tnKLkAga+1B19IB/6UmLV0mcI0Uk7XDDTgGzfC6E5Dy/f9FY7xhhg3E1Zuqo6TEQVahSzuxsTKSqk0UeGLtCtVYX2k0UTgAnC7ODagpWhOY+pbihFqe50ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.in; spf=pass smtp.mailfrom=nic.in; dkim=pass (1024-bit key) header.d=nic.in header.i=@nic.in header.b=U9E969Ic; arc=none smtp.client-ip=164.100.2.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.in
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=nic.in; i=@nic.in; q=dns/txt; s=NIC; t=1752499219;
  x=1784035219;
  h=date:from:to:message-id:subject:mime-version:
   content-transfer-encoding;
  bh=XO7Ib6cNjLBYafu+OY0GV6AScAnMGno5ATOomZu0n9s=;
  b=U9E969IcKiR5BLd5hNx/hvdxm2iWPKVvmzY6ZvX19W3k1tMWaFTgAaJF
   0sfcPMHCCq3wa/+f7wUOnQEgQkkHj/uM+iP///EHXtx4kclaINRe3/y/u
   Rfb+6smRKlpm9K4hS9etNFOdQv8xjCTkkLrBEJlxqe6FMBMFDq3HvHfMj
   E=;
Date: Mon, 14 Jul 2025 18:40:50 +0530 (IST)
From: Gaurav Kansal <gaurav.kansal@nic.in>
To: linux-wireless@vger.kernel.org
Message-ID: <535722602.4837437.1752498650922@nic.in>
Subject: Query regarding DFS detection method linux-wireless@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Thread-Index: JUpIbNKkA/a2ZhwWEuGGlOIG9sO4Bg==
Thread-Topic: Query regarding DFS detection method linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgZm9sa3MsIAoKSW4gdGhlIHdpcmVsZXNzIHJlZ3VsYXRvcnkgZGF0YWJhc2UgKGZvciBsaW51
eCBrZXJuZWwpLCB0aGUgcmFkYXIgc2lnbmFsIGRldGVjdGlvbiAoZm9yIERGUyBpbiA1IEdIeiB3
aXJlbGVzcyBiYW5kKSBtZXRob2QgZm9yIEluZGlhIHJlZ2lvbiBpcyBub3QgbWVudGlvbmVkLgpB
cyBwZXIgYmVzdCBvZiBteSB1bmRlcnN0YW5kaW5nLCB0aGVyZSBhcmUgdGhyZWUgZGV0ZWN0aW9u
IHdheXMsIG5hbWVseSwgREZTLUZDQyAoVVMgd2F5KSAsIERGUy1FVFNJIChFdXJvcGVhbiB3YXkp
IGFuZCBERlMtSlAgKEphcGFuZXNlIHdheSkuIAoKU28sIG15IGRvdWJ0IGlzIGhvdyB0aGUgbGlu
dXgga2VybmVsIG9yIHdpcmVsZXNzIGZpcm13YXJlIHdpbGwgZGVjaWRlIHdoaWNoIGRldGVjdGlv
biBtZWNoYW5pc20gdG8gdXNlIGZvciBJbmRpYSByZWdpb24gPwoKQXBvbG9naWVzIGlmIGkgYW0g
bWlzc2luZyBhbnl0aGluZy4KClJlZ2FyZHMsCkdhdXJhdiBLYW5zYWwKCgoKRGlzY2xhaW1lcjoK
ClRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gb2ZmaWNpYWwgSW5k
aWFuIEdvdmVybm1lbnQgaW5mb3JtYXRpb24uIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVsZXRl
IHRoaXMgZS1tYWlsLiBBbnkgZGlzc2VtaW5hdGlvbiBvciB1c2Ugb2YgdGhpcyBpbmZvcm1hdGlv
biBieSBhIHBlcnNvbiBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgdW5hdXRo
b3JpemVkLiBUaGUgcmVzcG9uc2liaWxpdHkgbGllcyB3aXRoIHRoZSByZWNpcGllbnQgdG8gY2hl
Y2sgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnQgZm9yIHRoZSBwcmVzZW5jZSBvZiB2aXJ1
c2VzLiAgIAo=


