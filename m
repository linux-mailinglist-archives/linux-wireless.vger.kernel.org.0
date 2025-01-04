Return-Path: <linux-wireless+bounces-17068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D29A0142C
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2025 12:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B12B1883885
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2025 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307614F125;
	Sat,  4 Jan 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMV6CvuR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD12F5E
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jan 2025 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735991854; cv=none; b=jVQImiD68rwwiqHcMobSnS39fMJEuL7Mqx4QJRyTeepN5bPkFRJNeuURhEzq+iRZcuCpMFD+aCixhZ0fk0hrHNtmFKuLAGgVJQAaLAQTsbqPquNJQKdLjFSh3bJm6eEBvViHHypDzLJibb2TpdDGY/lBO4CxgkR9afVSNDQFj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735991854; c=relaxed/simple;
	bh=biFsDKCqysqiYWRBXbVUvJQPTw4Ee/UvwvDzM8OBYo4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IZokxqmLNVodgmV/wIC/F5p/YZB2QFYV9kC3FgJBFs1GF1FgfDjUEIT7Fhyc7Aj41JtxmoTmlHrTpYRlPDXMB5wqe2dZBkR1pIIw6MkdSto7JRld1GUWoU0XGPYTNvH4K2yxK1N/j2Z+Ka8bwGHriIo1WoN4yAn5nY8v6likROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMV6CvuR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd43b08674so88486526d6.3
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jan 2025 03:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735991851; x=1736596651; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/0Y5iDgJcjVvhOUgkFmb502ELhhKAn4MbP+e7W3Sri4=;
        b=fMV6CvuR6Cl+DKibfuxBB3dxcdPiFRuDMoJo5Dq1Ktgs9HpqZZK9jNs4fMb3JbyW9P
         cB+NFPV6lzufCLBhCmvF2oyUZR+6v5yRgIxqnJunylkkXUL24NeDthHEMuSCPNbfNQA+
         QAKv/qMI1f8gtNAReQdftMQ34cAriNzSilprVkmXagogBxQaa5TABA/+cSVaS3Nq0Trv
         Egf1RbLxUXO7GGdJ2sex/+hhAt86tV4Fd8GF/J41UdlbJYMYP4MQXqWHahsua5NLKiSF
         kwfat0Tj62wM9biwaYbvh4FDfKqn59hKYnQvL88miJrji0DH2IxQTIsxZEIhCljgWgnN
         6CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735991851; x=1736596651;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0Y5iDgJcjVvhOUgkFmb502ELhhKAn4MbP+e7W3Sri4=;
        b=Q9oQ1O0XwtN2KT20dOIpqZySgTDG7dMc4ppnjH3I0LJeP5oteSWL7EyYCqOFYIhu7t
         jlRt0MQFTB7IBgH3SMsl9qe+Mm4D6ZtJv73LFbGewSxLflfJzttuHlxxLNapgRAWWJ4C
         e+drSJRzcA/Rr1XfX+INcvbx10Xgm8NgqAqJ7IkMvSRm1eCHlRM012xZVQNkbB2DO6l5
         nl1OqZt1Tzy2Q8p6lK2FVIGXOVTUEuzId4/9cPKXrcsIF4SVqS8jMxOvp42GLWvTYtA7
         wYZ6J4Fm7l+wSV7uLgTy1rIZYsTZ43aT/38L43yEG2dUI2Bb2XIEiteyGK8sMhrO+NvX
         iOyA==
X-Gm-Message-State: AOJu0Yy+UIRFF3GTGq/rAEWwHhZdEnVSLvWZBUkw6XqcL0ooFt+mdMa9
	FgQf60y1RyAP2F0r7NvhDa3EIejicRljAKl14USkyxXYfaQWk0rGXtW9BRoVUW9VS/Uw8Gj/c3w
	96MzWAJOCn1MTeRjSz1pgs75c7Odglt0mdHM=
X-Gm-Gg: ASbGncvgAO0gOCFCrX3O+Nt4ZECT+Y6voTEqsHnH8NOUQRtWqwOvrbXP5d56LRDk3Gh
	j5XDN1sz+5lxLmvoustbmJbBwdjT3NAQ5R3xkjG5XKt0rKqwM+5BoqXqe1VqLFnoAS910/r4=
X-Google-Smtp-Source: AGHT+IFNTwwgU3faBcUuinJGQOGajUFqxDhkmhAEJ5hQt8kQgO7yXcROxZi2MAZn+YZBZuUvuvmJuStsolxfciH3BQI=
X-Received: by 2002:a05:6214:21ab:b0:6d8:9b7b:14c9 with SMTP id
 6a1803df08f44-6dd2330924amr817208386d6.8.1735991851351; Sat, 04 Jan 2025
 03:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Patrakov <patrakov@gmail.com>
Date: Sat, 4 Jan 2025 19:57:05 +0800
Message-ID: <CAN_LGv38-uRvx9JqE6LBiF5tHLi9SwxRFpTN1v9tx7SvptV85g@mail.gmail.com>
Subject: Abysmally slow upload speed for iwlmvm in linux-6.11+ for forwarded
 traffic only
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.

I have a Dell laptop with this WiFi card:

02:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200
[8086:2723] (rev 1a)

Also, I sometimes run virtual machines on this laptop; thus, it has
the usual virbr0 bridge interface, of which the only slaves are tap
devices created by QEMU. The routing setup is a NAT created by
NetworkManager:

table ip nm-shared-virbr0 {
    chain nat_postrouting {
        type nat hook postrouting priority srcnat; policy accept;
        ip saddr 192.168.253.0/24 ip daddr != 192.168.253.0/24 masquerade
    }

    chain filter_forward {
        type filter hook forward priority filter; policy accept;
        ip daddr 192.168.253.0/24 oifname "virbr0" ct state {
established, related } accept
        ip saddr 192.168.253.0/24 iifname "virbr0" accept
        iifname "virbr0" oifname "virbr0" accept
        iifname "virbr0" reject
        oifname "virbr0" reject
    }
}

Up to and including linux-6.10.x, this WiFi card worked as it should.
When testing the performance of this card from the laptop itself
against iperf3 running on the router, everything is fine even on later
kernels (e.g., 6.12.7):

[aep@dell-laptop linux]$ iperf3 -c 192.168.10.1 -p 9999  # Upload
Connecting to host 192.168.10.1, port 9999
[  5] local 192.168.10.234 port 38596 connected to 192.168.10.1 port 9999
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  95.9 MBytes   803 Mbits/sec    0   1.40 MBytes
[  5]   1.00-2.00   sec   103 MBytes   862 Mbits/sec    0   1.28 MBytes
[  5]   2.00-3.00   sec   100 MBytes   839 Mbits/sec    0   1.79 MBytes
[  5]   3.00-4.00   sec   104 MBytes   877 Mbits/sec    0   1.30 MBytes
[  5]   4.00-5.00   sec   103 MBytes   866 Mbits/sec    0   1.05 MBytes
[  5]   5.00-6.00   sec  87.2 MBytes   732 Mbits/sec    0   1.02 MBytes
[  5]   6.00-7.00   sec   103 MBytes   865 Mbits/sec    0   1.39 MBytes
[  5]   7.00-8.00   sec   102 MBytes   856 Mbits/sec    0   1.58 MBytes
[  5]   8.00-9.00   sec   103 MBytes   866 Mbits/sec    0   1.54 MBytes
[  5]   9.00-10.00  sec   103 MBytes   862 Mbits/sec    0   1.42 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1005 MBytes   843 Mbits/sec    0             sender
[  5]   0.00-10.01  sec  1003 MBytes   841 Mbits/sec                  receiver

iperf Done.

However, when testing from virtual machines, with the host kernel
being v6.11 or later, the speed is way too low:

aep@debian-misc:~$ iperf3 -c 192.168.10.1 -p 9999  # Upload
Connecting to host 192.168.10.1, port 9999
[  5] local 192.168.252.80 port 33614 connected to 192.168.10.1 port 9999
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  32.1 MBytes   269 Mbits/sec   28   2.83 KBytes
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec   24   2.83 KBytes
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec   46   2.83 KBytes
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec   40   2.83 KBytes
[  5]   4.00-5.00   sec  1.38 MBytes  11.5 Mbits/sec   24   2.83 KBytes
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec   32   2.83 KBytes
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec   38   2.83 KBytes
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec   44   2.83 KBytes
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec   30   2.83 KBytes
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec   30   2.83 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  33.5 MBytes  28.1 Mbits/sec  336             sender
[  5]   0.00-10.01  sec  30.8 MBytes  25.8 Mbits/sec                  receiver

iperf Done.

I found that disabling TCP segmentation offload on the WiFi card helps
the upload performance inside the VM:

[aep@dell-laptop linux]$ sudo ethtool --features wlp2s0
tcp-segmentation-offload off

aep@debian-misc:~$ iperf3 -c 192.168.10.1 -p 9999  # Upload
Connecting to host 192.168.10.1, port 9999
[  5] local 192.168.252.80 port 59622 connected to 192.168.10.1 port 9999
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  92.6 MBytes   776 Mbits/sec    0   2.49 MBytes
[  5]   1.00-2.00   sec   104 MBytes   874 Mbits/sec    1   2.49 MBytes
[  5]   2.00-3.00   sec   103 MBytes   863 Mbits/sec    0   2.49 MBytes
[  5]   3.00-4.00   sec   105 MBytes   881 Mbits/sec    0   2.49 MBytes
[  5]   4.00-5.00   sec   105 MBytes   882 Mbits/sec    0   2.49 MBytes
[  5]   5.00-6.00   sec   106 MBytes   885 Mbits/sec    0   2.49 MBytes
[  5]   6.00-7.00   sec   106 MBytes   889 Mbits/sec    0   2.49 MBytes
[  5]   7.00-8.00   sec   102 MBytes   855 Mbits/sec    0   2.49 MBytes
[  5]   8.00-9.00   sec   107 MBytes   896 Mbits/sec    0   2.49 MBytes
[  5]   9.00-10.00  sec   103 MBytes   862 Mbits/sec    0   2.49 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.01 GBytes   866 Mbits/sec    1             sender
[  5]   0.00-10.01  sec  1.01 GBytes   865 Mbits/sec                  receiver

iperf Done.

I have tried bisecting between 6.10 and 6.11, but gave up, as too many
intermediate revisions either crash on the first forwarded packet, or
do not connect, or misbehave in other ways.

I am aware of https://bugzilla.kernel.org/show_bug.cgi?id=209913,
which looks similar. The difference is that the recent regression is
all about the forwarded traffic.

Could you please fix this regression?

-- 
Alexander Patrakov

