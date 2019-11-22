Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614D31071F5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKVMI4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:08:56 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44426 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKVMI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:08:56 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY7k6-0002e7-Or; Fri, 22 Nov 2019 13:08:55 +0100
Message-ID: <d1196ea09cf3024e352241353ad65e558d0c9393.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211_hwsim: support parent TSF feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 13:08:53 +0100
In-Reply-To: <20191119221541.11422-1-prestwoj@gmail.com> (sfid-20191119_231837_748319_729ACA97)
References: <20191119221541.11422-1-prestwoj@gmail.com>
         (sfid-20191119_231837_748319_729ACA97)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please split this patch. The only thing actually related to what your
commit log mentions is the first part setting the nl80211 feature bit.

The rest is just porting some existing code to the wmediumd code path.

johannes

