Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC145E97
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfFNNmR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 09:42:17 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42240 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfFNNmR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 09:42:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbmT9-0001G7-Kq; Fri, 14 Jun 2019 15:42:16 +0200
Message-ID: <2d0f10306a2ea2583d2e94e88875997678e65398.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] net: wireless: trace: add trace for tx_mgmt_expired
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <james.prestwood@linux.intel.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 14 Jun 2019 15:42:14 +0200
In-Reply-To: <20190612193510.27680-1-james.prestwood@linux.intel.com> (sfid-20190612_213640_498924_A969FAED)
References: <20190612193510.27680-1-james.prestwood@linux.intel.com>
         (sfid-20190612_213640_498924_A969FAED)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Applied, but

 * I squashed 1 and 2, there's no point in 1 standalone
 * please be more careful with indentation in the future,
   I fixed a few places.

johannes

