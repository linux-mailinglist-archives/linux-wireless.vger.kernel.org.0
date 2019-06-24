Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA97450602
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfFXJpV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 05:45:21 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:52590 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfFXJpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 05:45:21 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hfLXL-0006LV-3q; Mon, 24 Jun 2019 11:45:19 +0200
Message-ID: <90ccc515bb26b212b537fc1b0287afaa0f86fdf8.camel@sipsolutions.net>
Subject: Re: [PATCH] Add SPDX identifiers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     yegorslists@googlemail.com, linux-wireless@vger.kernel.org
Date:   Mon, 24 Jun 2019 11:45:17 +0200
In-Reply-To: <20190620130148.1674-1-yegorslists@googlemail.com> (sfid-20190620_150200_364028_4753B2C0)
References: <20190620130148.1674-1-yegorslists@googlemail.com>
         (sfid-20190620_150200_364028_4753B2C0)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-06-20 at 15:01 +0200, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Software Package Data Exchange identifiers help to detect source file
> licenses and hence simplify the FOSS compliance process.

Well that's nice and all, but it's also wrong.

You haven't included any documentation that says what the SPDX
identifier, and specifically the "ISC" tag means in the context of the
project, and it's not even the same license text as on spdx.org.

johannes

