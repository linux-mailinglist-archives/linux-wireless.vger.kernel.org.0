Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EFDE98C3
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 10:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfJ3JDv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 05:03:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56154 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfJ3JDv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 05:03:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iPjtN-0005Hy-ST; Wed, 30 Oct 2019 10:03:49 +0100
Message-ID: <4b9c7b36f175667a76609c6560618bb48a321ed8.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: allow more operations for mesh and ad-hoc
 interfaces
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Oct 2019 10:03:48 +0100
In-Reply-To: <20191029115602.78990-1-markus.theil@tu-ilmenau.de>
References: <20191029115602.78990-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-29 at 12:56 +0100, Markus Theil wrote:
> This change allows mesh and ad-hoc interfaces to change beacons and
> tx queue settings. The direct change of these settings should be ok
> for these kind of interfaces and should maybe only forbidden for
> station-like interface types.

"should maybe"? :-)

Not really, both of the changes are wrong.

johannes

