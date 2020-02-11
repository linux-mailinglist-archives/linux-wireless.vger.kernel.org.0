Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA4158C73
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 11:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgBKKNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 05:13:02 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55002 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBKKNC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 05:13:02 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j1SXN-002Njb-5q; Tue, 11 Feb 2020 11:13:01 +0100
Message-ID: <4f984c5a7ef4be18fb354ce78fcc32aad5f94a04.camel@sipsolutions.net>
Subject: Re: [PATCH 0/8] iw: parse measurement pilot and fix scan bugs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 11 Feb 2020 11:12:59 +0100
In-Reply-To: <4ae7d5c8-5e14-0cfc-e72a-82955d8e11e7@tu-ilmenau.de>
References: <20200209165902.44110-1-markus.theil@tu-ilmenau.de>
         <b5ac3a1aaa57cee8df1276d3a07d0f6f3f2ff207.camel@sipsolutions.net>
         <4ae7d5c8-5e14-0cfc-e72a-82955d8e11e7@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-02-10 at 09:22 +0100, Markus Theil wrote:
> I can also
> post my small patches doing this, but the current integration into the Makefile can
> be called "ad-hoc" at best :).

Please do, I can always fix up things but then I have some incentive ;-)

johannes

