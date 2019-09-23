Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858DFBB36D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfIWMNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 08:13:30 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37578 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfIWMNa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 08:13:30 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iCNDd-0002Hj-5i; Mon, 23 Sep 2019 14:13:29 +0200
Message-ID: <711186e8d875750f7ec962b0e96c3f1a050ae86d.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: initialize on-stack chandefs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Osipenko <digetx@gmail.com>, linux-wireless@vger.kernel.org
Date:   Mon, 23 Sep 2019 14:13:27 +0200
In-Reply-To: <4576d1ca-3af6-476b-7fb8-4b99dc77b92b@gmail.com> (sfid-20190923_141244_494530_57351873)
References: <1569239475-I2dcce394ecf873376c386a78f31c2ec8b538fa25@changeid>
         <4576d1ca-3af6-476b-7fb8-4b99dc77b92b@gmail.com>
         (sfid-20190923_141244_494530_57351873)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-09-23 at 15:12 +0300, Dmitry Osipenko wrote:
> 
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

That was quick, heh!

Thanks,
johannes

