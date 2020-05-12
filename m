Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F091CEA66
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 04:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgELCAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 22:00:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:22635 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgELCAC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 22:00:02 -0400
IronPort-SDR: 8tjHejZxPx4H6rnaIY8fKgGBhkOjwbhVzZDkN+ukjpjo+/JCGsa5H0JEp1Z9s3EyDdEegyFvdd
 NCE+hYtZiOMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 19:00:01 -0700
IronPort-SDR: KISenIb5qB5yclmk9k9YMzJWwk1y9ewHOcY+5LGqHEMCfrX4pTEKKne5MlA5t2hauGLYZ2Wxaa
 AS400SecdXCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="279962125"
Received: from xwang69-mobl1.ccr.corp.intel.com ([10.249.168.68])
  by orsmga002.jf.intel.com with ESMTP; 11 May 2020 18:59:58 -0700
Message-ID: <9056a7b3be9161c1ae266ac0266bdb0ab386de66.camel@intel.com>
Subject: Re: [PATCH 5/6] thermal: core: introduce tz_disabled() helper
 function
From:   Zhang Rui <rui.zhang@intel.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, andrzej.p@collabora.com, luca@coelho.fi
Date:   Tue, 12 May 2020 09:59:57 +0800
In-Reply-To: <4aa6fd7d-9e0c-614a-88e9-0e2637a114d4@samsung.com>
References: <20200430063229.6182-1-rui.zhang@intel.com>
         <CGME20200430062922eucas1p288a6f222286b4293b32272a3da1166ab@eucas1p2.samsung.com>
         <20200430063229.6182-6-rui.zhang@intel.com>
         <4aa6fd7d-9e0c-614a-88e9-0e2637a114d4@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-05-04 at 09:09 +0200, Bartlomiej Zolnierkiewicz wrote:
> On 4/30/20 8:32 AM, Zhang Rui wrote:
> > Rename should_stop_polling() to tz_disabled(), and make it global.
> > Because there are platform thermal drivers which also need this.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/thermal_core.c | 17 ++++++++---------
> >  include/linux/thermal.h        |  2 ++
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c
> > index 5f7a867..1cd5d5d0 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -305,16 +305,9 @@ static void
> > thermal_zone_device_set_polling(struct thermal_zone_device *tz,
> >  		cancel_delayed_work(&tz->poll_queue);
> >  }
> >  
> > -static inline bool should_stop_polling(struct thermal_zone_device
> > *tz)
> > -{
> > -	return thermal_zone_device_get_mode(tz) ==
> > THERMAL_DEVICE_DISABLED;
> > -}
> > -
> >  static void monitor_thermal_zone(struct thermal_zone_device *tz)
> >  {
> > -	bool stop;
> > -
> > -	stop = should_stop_polling(tz);
> > +	bool stop = tz_disabled(tz);
> >  
> >  	mutex_lock(&tz->lock);
> >  
> > @@ -502,12 +495,18 @@ int thermal_zone_device_set_mode(struct
> > thermal_zone_device *tz,
> >  }
> >  EXPORT_SYMBOL_GPL(thermal_zone_device_set_mode);
> >  
> > +bool tz_disabled(struct thermal_zone_device *tz)
> > +{
> > +	return thermal_zone_device_get_mode(tz) ==
> > THERMAL_DEVICE_DISABLED;
> > +}
> > +EXPORT_SYMBOL(tz_disabled);
> 
> Is there actual reason to not make it _GPL?
> 
> [ all other thermal core functionality seems to be _GPL anyway ]

Thanks for catching this, will fix in next version.
> 
> Otherwise the patch looks fine:
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

thanks for the review.

-Rui
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> > +
> >  void thermal_zone_device_update(struct thermal_zone_device *tz,
> >  				enum thermal_notify_event event)
> >  {
> >  	int count;
> >  
> > -	if (should_stop_polling(tz))
> > +	if (tz_disabled(tz))
> >  		goto update_polling;
> >  
> >  	if (atomic_read(&in_suspend))
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index a87fbaf..0bc62ee 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -479,4 +479,6 @@ static inline int
> > thermal_zone_device_disable(struct thermal_zone_device *tz)
> >  	return thermal_zone_device_set_mode(tz,
> > THERMAL_DEVICE_DISABLED);
> >  }
> >  
> > +bool tz_disabled(struct thermal_zone_device *tz);
> > +
> >  #endif /* __THERMAL_H__ */
> > 
> 
> 

