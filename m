Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC2340C07
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 18:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCRRn6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 13:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRRn2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 13:43:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BB3C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 10:43:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t18so3305677pjs.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=t6/QtnKjLzmZoU8WRHnrEpbPUW585LWomtjUVqBBQIw=;
        b=ukrC7vnynOsRdDURgfH6lb1Bl5tH7GyOF/ZxrgGIkH/L/CJey7IsfpAmaPExWGshdz
         FEGl+Cx+UC2GURMlZWSuRf82DwMS28FGnDd+UpEqTvMOue+p5/O4Z3OXYy9D35rUD892
         E+QENtA9dMyYVKXCm25enIB6TynkylLcEkQdM8gI5TZ9QjS/ghxe6Gsg/vDtB0aafdj/
         r2TjewQ3uWbQhHh70xMDQmP2G4r3YAdLcrmMVdygVBqJqOFnN0umwOqkC4Nn10AHCAkm
         gOpUGdq1SiyIRzD0nkHr3nzXlFkju2C/BvVewX3wLrNtgBkYwAEaHvFuJugNQhMw9/Rq
         +46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=t6/QtnKjLzmZoU8WRHnrEpbPUW585LWomtjUVqBBQIw=;
        b=N4Z3LT97aVz+Xc1V6Z8Tac74t31hip6RU1p429HO+8filZP8b7/osCYAuetOIRXtXk
         +wXZ6vfEjKHZBHs3kPB0JhcqXUYavVn9ECxNLUwkVyT88uIvzMmJ3z37zdFtAkIbyMEK
         GLCmn7XttKtl6h15pkIisoQqnWlvlJ1afXIn7gV7Gvtsp1rGib+ovPUWDzv+B8hEFLoP
         wmMoBnHdQ+tx3hFkqhH7Y7RkfKkgXVFuZDWSrz3LQce8RfK4/7KtQ39+4akNpMa/Zmtg
         fgrrh7S6ECuzI2IP/uqIJWjlwgo/wj3mTvuoBwz0vljEJdsGpTiLyWBWed+98bwiw2O9
         z5Gw==
X-Gm-Message-State: AOAM531/t7bTXvEH7o6qvedgyTYIhKU395XvOLXyY/ny5UKLUDj3ahYY
        Ve+wOLANQO7AxBvuS+bGtUgukv6swF0=
X-Google-Smtp-Source: ABdhPJxz9SckAr/eEl3s6zM3Fu27IpnoZP6PKJ8+v803OoofupzQfp7X8YQIPbPNk97ZP5B9XQVtXg==
X-Received: by 2002:a17:902:dac2:b029:e6:30a6:4c06 with SMTP id q2-20020a170902dac2b02900e630a64c06mr10914989plx.65.1616089405637;
        Thu, 18 Mar 2021 10:43:25 -0700 (PDT)
Received: from jprestwo-xps ([50.39.173.103])
        by smtp.gmail.com with ESMTPSA id 184sm2659078pgj.93.2021.03.18.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 10:43:25 -0700 (PDT)
Message-ID: <975404e3eebd91ccf17b172eb0969a5256c7fef3.camel@gmail.com>
Subject: PSK/1x offload documentation ambiguity
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     eliad@wizery.com
Date:   Thu, 18 Mar 2021 10:43:24 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I see the API documentation for PSK/1x offload is somewhat ambiguous
with respect to if the hardware actually supports user space 4-way
handshakes. Both extended features say this regarding doing the 4-way
in the host:

"..., doing it in the host might not be supported"

So far the hardware I have used does support user space 4-way
handshakes so I have not yet bothered with offload. But this comment is
concerning if a user comes along with hardware that *does not* support
the 4-way in userspace. It would be nice to know if this comment is
complete bogus, or if there is actual hardware which does not support
user space 4-way handshakes. And if there is such hardware, how can
userspace know the difference.

I've CC'ed Eliad who is the author to 91b5ab6289 which added this
support.

Thanks,
James


