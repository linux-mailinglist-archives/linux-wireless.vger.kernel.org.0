Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591186B0B6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2019 23:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbfGPVBy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jul 2019 17:01:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37183 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731214AbfGPVBy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jul 2019 17:01:54 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hnUa8-0002Af-LC
        for linux-wireless@vger.kernel.org; Tue, 16 Jul 2019 21:01:52 +0000
Received: by mail-io1-f70.google.com with SMTP id n8so24660555ioo.21
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2019 14:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KJll5Axh0kMoPVnX1zKO5pruzpdr1ISgW101aliA2ww=;
        b=NS6fLaJfW8llna/RtLa6SlVCgqQ3bZzyqDNY7BeK0kk9cb3zhFnJAfq0psndiG4fhW
         GNgEln6ycTGcGKqaYRZ0VOCyxYtu948x4tYK4GKGT0szT2xSbsngo8tWueb1ufxfhOuY
         R6wygak0r5Crxn6wnoMk5mSw+2Wz9O3hMa3iqgRIagKlvzRlxqDvF8N4sUexpod1Ka4w
         Eh6QxJ4Wky9fGjvMdMSyyJ0VFLRKTLg3UxdtiGC3jtWWZFa8Rnq855/Y0awmP7CaEyHb
         5lDy1gXskakcN9o5wDfwZuSECtJnW92z7yQ+TBhr6e9j53lC/dmPqkmNo6iB/fO5XQlB
         FDwg==
X-Gm-Message-State: APjAAAVQkMiNt58pQVcfFc92rCigzJV+HDekn/xkUYWbnoK0Ql+iUwe8
        eFTJBIoExs6VZajDOpUHHCfJAR+MmBGDg8cVksj8lmTrHzNTqfJUiqFmQzkrwsXnIVKc5Ln05lu
        JAS9Tmg8kZM3S4eo8vpHCbNdLjuRkJslJq3xln9R+TMJQ
X-Received: by 2002:a5e:9308:: with SMTP id k8mr32529462iom.143.1563310911482;
        Tue, 16 Jul 2019 14:01:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxO79KuFJweS4Ji2htkmm8hZqkhJreOHg4eOEUUtk5/1d6JREj5jjCEArAua1rz0BMx04c0bg==
X-Received: by 2002:a5e:9308:: with SMTP id k8mr32529424iom.143.1563310911153;
        Tue, 16 Jul 2019 14:01:51 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:31dd:dc66:96d:f1eb])
        by smtp.gmail.com with ESMTPSA id h18sm17494436iob.80.2019.07.16.14.01.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 14:01:49 -0700 (PDT)
Date:   Tue, 16 Jul 2019 16:01:48 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     gb@inrete.it
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Subject: Re: [wireless-regdb] Update to wireless-regdb about Italy
Message-ID: <20190716210148.GQ5418@ubuntu-xps13>
References: <20190702141944.25902-1-martin@strongswan.org>
 <20190713130253.GH5418@ubuntu-xps13>
 <8c7c0973-b1c9-0032-1819-e868855b896f@inrete.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c7c0973-b1c9-0032-1819-e868855b896f@inrete.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Jul 13, 2019 at 07:10:37PM +0200, gb@inrete.it wrote:
> Hi
> 
> I'm Italian and I work in Italy, I realize that nowadays the regdb entry for
> Italy is as follows:
> 
> country IT: DFS-ETSI
>     (2402 - 2482 @ 40), (20)
>     (5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
>     (5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
>     (5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
>     # 60 GHz band channels 1-4, ref: Etsi En 302 567
>     (57000 - 66000 @ 2160), (40)
> 
> And it misses the lines:
> 
>     # Short Range Devices (SRD) (ETSI EN 300 440)
>     (5725 - 5875 @ 80), (25 mW)
> 
> Common to may European Countries.
> 
> I dug a bit in the current Italian regulation that is online on the website
> of the
> Ministry of Economic Development: https://www.mise.gov.it/index.php/en/
> 
> In the section about the "National Plan of Frequencies" (only in Italian) at
> the URL:
> 
> https://www.mise.gov.it/index.php/it/comunicazioni/radio/pnrf-piano-nazionale-di-ripartizione-delle-frequenze
> 
> 
> Two PDF files are linked:
> 
> --Tabelle di attribuzione Tabella B (27,50 MHz – 10.000 MHz) (pdf)
> https://www.mise.gov.it/images/stories/documenti/Tabella_B_2750_MHz-10000_Mhz.pdf
> 
> Which at page 28 allows the use for ISM according to the general European
> legislation: 2006/771/CE ERC/REC 70-03
> 
> --Note (esplicative, di carattere tecnico e con attribuzioni in deroga al
> piano) (pdf)
> https://www.mise.gov.it/images/stories/documenti/NOTE-pnrf.pdf
> Which at page 334, in the paragraph 3.2.3 states in a explicit way the
> permit to operate the in the band 5.725 ÷ 5.875 MHz,
> with SRD and max power at 25 mW.
> 
> According to this regulation there's no reason not to have the:
>  (5725 - 5875 @ 80), (25 mW)
> Inserted for Italy in the regdb
> 
> Who can do it ?

The page/section numbers you gave for the second document don't
correspond to what I'm seeing, but it does look like you are right that
the entry can be added to the regdb. Anyone can send patches for the
regdb, so if you know how to do that please feel free to do so.
Otherwise let me know and I can prepare a patch.

Thanks,
Seth
