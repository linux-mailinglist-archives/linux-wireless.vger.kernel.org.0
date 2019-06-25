Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC352750
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 10:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfFYI5d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 04:57:33 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:54868 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfFYI5d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 04:57:33 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hfhGa-0004ub-Do; Tue, 25 Jun 2019 10:57:28 +0200
Message-ID: <f41ef885311c30539fde5d5b696866a63b79f17b.camel@sipsolutions.net>
Subject: Re: nl80211 wlcore regression in next
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Date:   Tue, 25 Jun 2019 10:57:27 +0200
In-Reply-To: <a863a74f-c6a9-b862-d17e-bc5f1dbe980a@broadcom.com> (sfid-20190625_105642_518599_389D67F7)
References: <20190625073837.GG5447@atomide.com>
         <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
         <20190625080019.GH5447@atomide.com>
         <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
         <a863a74f-c6a9-b862-d17e-bc5f1dbe980a@broadcom.com>
         (sfid-20190625_105642_518599_389D67F7)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,


> By chance noticed the patch included brcmfmac. So I tried, but I get 
> compile issue below. It is because ERR_PTR really is an inline function 
> so that is not working. So also need to patch that. I left the extra 
> braces around the error code although not strictly necessary.

D'oh. I'll check that out, thanks for the report/patch!

johannes


