Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278C415CBD7
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 21:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgBMUTV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 15:19:21 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:48446 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBMUTV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 15:19:21 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2KxD-009e2Z-GE; Thu, 13 Feb 2020 21:19:19 +0100
Message-ID: <03361a0c6f35db6aac6eab650d35e8ade0541d21.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] iw: add clang-based fuzzer for scan IEs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 13 Feb 2020 21:19:17 +0100
In-Reply-To: <20200211114502.4250-1-markus.theil@tu-ilmenau.de>
References: <20200211114502.4250-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FWIW, I applied most of your patches, though some I squashed since you
just introduced the bugs in a previous non-applied patch ... :)

Regarding the fuzzing ... how long did you run this?

I adjusted this to afl-clang-fast (afl++, not the original) and it's not
finding much easily...

I guess making it realloc each element into a separate buffer so that
it's checking out-of-bounds for each element separately will help
somewhat, let's see...

johannes


