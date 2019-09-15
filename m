Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5115EB3239
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2019 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfIOVf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Sep 2019 17:35:29 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:33892 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfIOVf3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Sep 2019 17:35:29 -0400
Received: by mail-io1-f54.google.com with SMTP id q1so2005255ion.1
        for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2019 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=++bAoxlksPOcvEg1gGnU8F7I0tI2kxi/6+syB3SJEvg=;
        b=Flhji9abENEJeLZejltbeynVXYxC/G6vyZTcNsTMCQVWep/9mtlGjwyfJeRFlvYSZ/
         vUuogPV2g7PJFPhw3FCLx5o568AWtMp3PsXHZ1x5rrCytgQ5jfcZwtZpKgdD0wNdUeEL
         xAZGSEzXGZTif5C9cTY1bWWlWiEoptFNl7E2B0zX0/fbNVMkJA/dc12b7HKv3gUdtcIS
         M0io7pyCaOknsZQHvJLTxlh9Oz1Yd8ohZsMG6hXw4F/gqgZJl7ezZF1zQVuyUas43ZyO
         kdZfYDmDgHaC35UjL7n3K35O9zk+ptXJqZFPicUQXBeNfpyI9xdctnAellyUapwu/lNn
         qvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=++bAoxlksPOcvEg1gGnU8F7I0tI2kxi/6+syB3SJEvg=;
        b=qqvkqZo52aB+fzwXjA6WwxA0YZYAuUIQuRTYzGntbYRQ4WNVmx6LpdUH2nbchBnS3G
         kTJBuBrJB5KhErgPhGOdKtyOO/A5HWqM0fU/sJMGfIuxMzI5IFpB2no1TQgn1MHWY7WM
         zu9eLBhk5gwfDQGWoSKolUDRqItTFABk5FGupJzgSCej3t1B4vZ1HKA+S5O8p1/1dyBC
         Di/Q/gf9KM0RW63uW0/6e/tDmuID42tasH3eFgLLKYx+CZYfcnb7y4DPfIJZR2a/rESy
         6VfO6nKYYs32iDCR3tx9Se/57kofFKhGKxzIcu6ePmz0R6bPZdkxJvaYA30YN5zYcQcA
         7Gzw==
X-Gm-Message-State: APjAAAXuioG3jrka1DXjaTmXgsl5NO/3uY5KLIbwEfgEYyDJhDcifxOx
        HP/unbDQh2kzZEkJPhZtM4GMbp2Jq5ZQ24qdmO65N0R2
X-Google-Smtp-Source: APXvYqz0+rk2Xh2cTkWN1LEpDa2rxH2Dg2SEebZfvXjFilMcNw/PngxqK78FBVyHGdafAFHmu7nktgFMRDAKhzcLpTg=
X-Received: by 2002:a6b:e618:: with SMTP id g24mr5203678ioh.277.1568583328180;
 Sun, 15 Sep 2019 14:35:28 -0700 (PDT)
MIME-Version: 1.0
From:   Olli Niemikorpi <mr.oole@gmail.com>
Date:   Mon, 16 Sep 2019 00:35:16 +0300
Message-ID: <CAFXqH2MPhju-GNfwhcubLssZP5CuQAdENtQQ2TdgTNk0pur=Gg@mail.gmail.com>
Subject: Wireless-regdb: Update regulatory rules for Finland (FI) on 5GHz
To:     seth.forshee@canonical.com
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Based on https://w.wol.ph/2015/08/28/maximum-wifi-transmission-power-country/
, maximum output power for 5Ghz is 30 dBm from channel 100 and above.
However, only 27 dBm is maximum in wireless-regdb. Could you please
fix it?

BR Olli Niemikorpi
