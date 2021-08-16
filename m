Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8463ED9ED
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhHPPfp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 11:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhHPPfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 11:35:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A09C061764
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 08:35:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id z20so32547578ejf.5
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=F50x1xdP0SvV+obOXSt5hkF5XqI9E8xqi5vkcru5GzU=;
        b=jMzoF776DpfxSqec3sblq15divpRddE/BAndm6/pZXczcPVdv1f5xfOpgkXVIZEukI
         bVCqmNZ6Fe0/jyTDzHZPzZotcc4vHeMU2El21ghUrI51S8RY6Xx+0+hOK/a3qf3FufC6
         Nn/RT/jmmINWKyGPSmRsBNxkQn+vt6TCtppQ7OQ/lvN8EyhlZGoEe/xtfYQODeHb5kb/
         9QfTxj2J2/CNp28mvWn8eM/rBft3Xbjk1jltGZydob1yS8ds3ZiLcW1U3u6gOD3d0qjj
         RDNj80Kwl0NX1gk58ctakWur8q9R8BawHb+Vj/aFBXb/GfhnjbVI+W19hmixC9UEoqBL
         aeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=F50x1xdP0SvV+obOXSt5hkF5XqI9E8xqi5vkcru5GzU=;
        b=Q7OW8do27e0YOgyEfLZQFqDjlLkau3U79kxTvNyaLFaaD7gHLrNxbXRk2hKPwpyU6C
         sdzz3R408fad+VlQA4GJcRJY0dXZAaWQaIIppqY1UZrUdhkQnx39q0Ga75ypUHIMMGuI
         U8XYchHV60Ghxpz5Fjjabu55Z83qzLn/XO+P/FLuXJaYzWctfjxxjXUO7Omd+NL+l9fj
         i5uNNIrnMx25QeFnT03lMhDzgKqd+7B2QzPGSETggdDoIpuGJfhEcECOzVaMDqnT6Fls
         gglcqDzK4O64SnsC3zG9SD6ujdg7CLfqJNSiLYmUYw2R08D5bSk4aRrAwymM9HmBBft9
         rx0g==
X-Gm-Message-State: AOAM533zVi4ZUYXBCY3BFIAg6UFVulX2HVeq9J4efa/mBkYELn9woHmQ
        LS2jOkeMONYfArvPp9I1ffMWVlCkZDyRn8syd2UR4ipVs0o=
X-Google-Smtp-Source: ABdhPJwIB/DEq4iL8x4JSN7pWeveWFQtlqXnTRo2AqW7IbwoEbdrBfocye+l5j6zW80xdTB0D9pAEb9zASXEpdUhWsc=
X-Received: by 2002:a17:907:d09:: with SMTP id gn9mr16875035ejc.447.1629128107354;
 Mon, 16 Aug 2021 08:35:07 -0700 (PDT)
MIME-Version: 1.0
From:   Milo Garcia <ing.eagm@gmail.com>
Date:   Mon, 16 Aug 2021 17:34:56 +0200
Message-ID: <CAAZjYunwQ5UtjJuvrBNWU9qTf72WMRjoaYD+mgn7OaqmXXZ+fw@mail.gmail.com>
Subject: iwlwifi: OFMDA Sniffer not capturing actual data
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi buddies,

I am using the Intel AX200 to capture OFDMA DL traffic. I used the
next command to sniff 11ax OFDMA packets
echo [AID] [MAC AP] > /sys/kernel/debug/iwlwifi/*/iwlmvm/he_sniffer_params

I am able to see HE_MU packets but they don't contain the actual data
in the RUs. Wireshark says "NOT CAPTURED BY CAPTURE SOFTWARE"

Is it possible to get the possible RU Data from iwlwifi?

Regards, Milo Garcia
