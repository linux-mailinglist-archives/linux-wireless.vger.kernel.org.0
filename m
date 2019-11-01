Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CC6EC730
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 18:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfKARDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 13:03:38 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:45854 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfKARDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 13:03:38 -0400
Received: by mail-oi1-f176.google.com with SMTP id k2so8697842oij.12
        for <linux-wireless@vger.kernel.org>; Fri, 01 Nov 2019 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nbSFtak1O3UwnxaQBm0ucn+fe7UGXwhE5nnddEBZqow=;
        b=r7O0Yy+VgEy6hVKre4HYjx+85FRbDNOEWAlZSR08Ks/9lhBzd0R9pPYZdG5gInjNOO
         diKWMdxGQpMLVG+2sTYFMZ+uGm1LJfyR7WroDFaPgUNNLDrZv0+dUy73B6QpthaI56Ms
         FSj1DGT/kPYMUo4cpQnALnnB2gSajwINozpP0jW0cEmd6d9PUahgUTT/1pak+o4eKLpJ
         C0TugoH7lz/G/dd0hGVbBSlFRPNp232lB986xDsEudvtn+w59UfQcyhSWoBQ8w0I93dK
         xLIMKGPnFF/VBp6shCrR8x6ewf9Yed6UkD/RK2iG7MQB++4/yLnI8eughHJMx7TycUXr
         KtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nbSFtak1O3UwnxaQBm0ucn+fe7UGXwhE5nnddEBZqow=;
        b=j8Cx5aQb9m2jeNf6x4SPeKVsmtkRT2yESnsk91ucNst4j6yGleycR8QZ82F0BEL4CG
         fU7+RpinpftVT8raQPTbOqHmF46gwynJxrKoamiGL3ie+STOUcXHGB33xgeOYL+d3Kcc
         7NnU5MlSqtAIrOj8aPZWbVNqNtLV6P70oThi+mish/A6fiS709YlamJszkn45iYdCr5L
         nH746WqD5jgSy+4X1u8F5atxTzb7nO+UFyn7uG5Ta6mSsQyhrrTBab/98tmz9Q+ZvYpL
         TPN/wOzZiCFn4VFawtxkFOSUfnEernw6PDGe2dTdY5utfhylTOBqWjoEUIF1d6TICe4+
         8eiw==
X-Gm-Message-State: APjAAAViyIny6tXEqY2iyncTdxe3ZVwj9mKH4Rjqxn9BE5qaGR7YSM5S
        NQTWWb8SHAUQt9RirK71nxKBD/cCHJgIhWHU1Jc=
X-Google-Smtp-Source: APXvYqwhy7pq2vWx+VYPLaYlpEadZ5guse7bAZE+zzN+Zm7Elv6Ty+NGak7Koaz+IHjmCj9GjUYFwdd4WYKVhR5Xs1Q=
X-Received: by 2002:a54:448b:: with SMTP id v11mr3944220oiv.155.1572627817258;
 Fri, 01 Nov 2019 10:03:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7511:0:0:0:0:0 with HTTP; Fri, 1 Nov 2019 10:03:36 -0700 (PDT)
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Fri, 1 Nov 2019 18:03:36 +0100
Message-ID: <CAKR_QVJ2eHrESLOEqiKxbjr0SoZh3oJydtgcebBOXSpspbquWA@mail.gmail.com>
Subject: [RFC] ath10k: interface combination with monitor
To:     ath10k <ath10k@lists.infradead.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

Is there a way to run monitor mode interface independent on STA/AP
interface presence or their state?
I am using airodump-ng/airmon-ng and I've noticed that while mon
interface is brought up airodump-ng is unable to find any beacons
unless sta interface is brought down. That is with QCA9880 devices,
while with QCA9377 airodump-ng only finds beacons if the sta interface
is associated to an AP.
Does this need firmware change to work or driver changes are sufficient?
