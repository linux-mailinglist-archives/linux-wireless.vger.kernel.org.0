Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9532C5D1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfE1Lv7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 07:51:59 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48534 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfE1Lv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 07:51:59 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hVae6-0004HX-7R
        for linux-wireless@vger.kernel.org; Tue, 28 May 2019 13:51:58 +0200
Message-ID: <c138fac51c7f49bbcd8617ae0a2c750d78abb35d.camel@sipsolutions.net>
Subject: FYI: vendor specific nl80211 API upstream
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Date:   Tue, 28 May 2019 13:51:55 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

FYI - at the discussions in Prague we decided to let some vendor
specific nl80211 API go upstream, and I've just documented the expected
rules here:

https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

I guess this will be fine-tuned as we go along, but wanted all to be
aware.

johannes

