Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC537B337
	for <lists+linux-wireless@lfdr.de>; Wed, 12 May 2021 02:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhELA4Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 20:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELA4X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 20:56:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92907C061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 17:55:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b21so10229686pft.10
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 17:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=11LIPUj+/FEY28zLXi+or8MFIxpwei/42kdufWNvYWI=;
        b=fNGeBskj3yNXA0Iu9yGMpYr5sfvf7vr/TGi4pZnNRWYOLRtPlh7RIBNT7ylTk+IlaA
         rYl0SDo/sqaY3BL9ZIFOm/m9DzB6Q9QvzOd7B3ZbaW5OFX4tyxUiMtw0BCdUeBLaGG7D
         iSIPK3p4b607i5/dzrEpNDH1Dlyt4DnmDaH03iwSXzHR2JNoQKpec3gUmiAEuvjERNFd
         NMgE3xBjSrTqTZ6tn9y6rj1eu8MgusTyMns+jSmo8xC1O9tNcfDzwgwo3++DwyVNicAR
         imKLFef1LqIB/c4y/iM2ia5qZ6BYeNw6LalyAiqnW7Z9YeLsDvgI9Q6EtTPdj8eJ2a7+
         Bi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=11LIPUj+/FEY28zLXi+or8MFIxpwei/42kdufWNvYWI=;
        b=PlhJLWA3J3HrJqkhTqnQv6kyFf0mh9cjpduSa6TIhxQx7R+Rza07F7tv0nroD6qeIG
         oMJy8OjHLyNloM4pSFSDR9rOhgEgf/jvv7AsuiDGa2kM7y110/UffRG0DmB3DIGeBf+2
         DJM+mSElf76bwtjfTjHJe5NEyxICI6KiSlm3kqq1qDARSY/oPMK0VlvoqXqB7K4HG+f1
         zoC+AzxpN5NPNU4cfDYMITjXFQvQTf1nPny3YDNOkmWeU7BzP29rfWw2tfUZoYJ4SG5v
         XPACd0kcYxXwwaWfUE96zwYSdvjnLLcXEZRJxBkDMoeIwnQphpviD3AJwAVb0U0S/gpF
         255g==
X-Gm-Message-State: AOAM5339YDKev8KJkpNPYqAzQ45Ho3XNckWHNxuX5MEtRlPa2dFENjLX
        b7Vd+jPB/ujzRgEyd6TgxRk=
X-Google-Smtp-Source: ABdhPJwu7CARJpZBEEdWFiaSEpJWaAbz619HAroqV7THYM7SlP+ngr5723Ct5eSZtHRhHUCCbL93Pw==
X-Received: by 2002:aa7:87d6:0:b029:28e:5d2d:4590 with SMTP id i22-20020aa787d60000b029028e5d2d4590mr32241950pfo.13.1620780914975;
        Tue, 11 May 2021 17:55:14 -0700 (PDT)
Received: from nuc ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id s6sm14627922pgv.48.2021.05.11.17.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 17:55:14 -0700 (PDT)
Date:   Wed, 12 May 2021 08:55:10 +0800
From:   Du Cheng <ducheng2@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Thomas Pedersen <thomas@adapt-ip.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot+405843667e93b9790fc1@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: mac80211: fix hard-coding of length check on
 skb->len in ieee80211_scan_rx()
Message-ID: <YJsnbhkOLSPqFMLM@nuc>
References: <20210510041649.589754-1-ducheng2@gmail.com>
 <e52ff0a3-7b64-037d-7825-9cbbcafa21b6@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e52ff0a3-7b64-037d-7825-9cbbcafa21b6@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Le Tue, May 11, 2021 at 04:29:07PM -0600, Shuah Khan a écrit :
> On 5/9/21 10:16 PM, Du Cheng wrote:
> > Replace hard-coding with compile-time constants for header length
> > check on skb->len. This skb->len will be checked again further down the
> > callstack in cfg80211_inform_bss_frame_data() in net/wireless/scan.c
> > (which has a proper length check with WARN_ON()). If the kernel is
> > configure to panic_on_warn(), the insuffient check of skb->len in
> > ieee80211_scan_rx() causes kernel crash in
> > cfg80211_inform_bss_frame_data().
> > 
> 
> Where is this WARN_ON? I didn't see it cfg80211_inform_bss_frame_data()
> 
> Please add more information on why the values of min_hdr_len in this
> patch make sense for each of these cases.

Hi Shuah,

The WARN_ON() is located here:
linux/net/wireless/scan.c: 2331
```
    if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
        ext = (void *) mgmt;
        min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_beacon);
        if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
            min_hdr_len = offsetof(struct ieee80211_ext,
                           u.s1g_short_beacon.variable);
    }

    if (WARN_ON(len < min_hdr_len)) // <- warn_on line
        return NULL;

```
the min_hdr_len that I added in was following the setup of min_hdr_len before that
WARN_ON(len < min_hdr_len)

> 
> > Bug reported by syzbot:
> > https://syzkaller.appspot.com/bug?id=183869c2f25b1c8692e381d8fcd69771a99221cc
> > 
> > Reported-by: syzbot+405843667e93b9790fc1@syzkaller.appspotmail.com
> > Signed-off-by: Du Cheng <ducheng2@gmail.com>
> > ---
> > 
> > This patch has passed syzbot testing.
> > 
> >   net/mac80211/scan.c | 18 +++++++++++++-----
> >   1 file changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
> > index d4cc9ac2d703..562eda13e802 100644
> > --- a/net/mac80211/scan.c
> > +++ b/net/mac80211/scan.c
> > @@ -251,13 +251,21 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
> >   	struct ieee80211_mgmt *mgmt = (void *)skb->data;
> >   	struct ieee80211_bss *bss;
> >   	struct ieee80211_channel *channel;
> > +	size_t min_hdr_len = offsetof(struct ieee80211_mgmt, u.probe_resp.variable);
> > +
> > +	if (!ieee80211_is_probe_resp(mgmt->frame_control) &&
> > +			!ieee80211_is_beacon(mgmt->frame_control) &&
> > +			!ieee80211_is_s1g_beacon(mgmt->frame_control))
> > +		return;
> 
> Is the above check necessary? This doesn't look right. This skips
> the ieee80211_is_s1g_beacon() all together.

the original check only has the first two conditions (ieee80211_is_probe_resp()
and ieee80211_is_beacon()), but they were placed after condition of
ieee80211_is_s1g_beacon() not being met. Since I moved these checks at the
above, _before_ the if(ieee80211_is_s1g_beacon()), hence I joined
ieee80211_is_s1g_beacon() with the two orginal conditions.
> 
> 
>    	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
> > -		if (skb->len < 15)
> > -			return;
> 
> Why not compare the header offset you expect here instead of 15 and
> return?

In fact, I do not understand where 15 (and the 24 shortly after) comes from.
They were there more than 10 years ago, but the more recent guard code in
cfg80211_inform_single_bss_frame_data() on the same header length seems more
correct, therefore I followed examples and copied the calculation from there,
for consistency.
> 
> > -	} else if (skb->len < 24 ||
> 
> Can you explain why it makes sense to remove < 24 check?

I replaced 24 with 
`size_t min_hdr_len = offsetof(struct ieee80211_mgmt, u.probe_resp.variable);`
which was found in cfg80211_inform_single_bss_frame_data(), for conditions:

	ieee80211_is_probe_resp(mgmt->frame_control)
or
	ieee80211_is_beacon(mgmt->frame_control)

> 
> > -		 (!ieee80211_is_probe_resp(mgmt->frame_control) &&
> > -		  !ieee80211_is_beacon(mgmt->frame_control)))
> > +		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
> > +			min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_short_beacon.variable);
> > +		else
> > +			min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_beacon);
> > +	}
> > +
> > +	if (skb->len < min_hdr_len)
> >   		return;
> >   	sdata1 = rcu_dereference(local->scan_sdata);
> > 
> 
> thanks,
> -- Shuah

Best regards,
Du Cheng
